<?php

namespace PageBlocks\App\Services;

use Boshnik\PageBlocks\Models\PbMigration;

class MigrationService
{
    protected string $appPath;
    protected string $migrationsPath;
    protected string $phinxBin;
    protected string $phinxConfig;
    protected string $phinxLogTable;

    protected array $textLimits = [
        'tinytext'   => 255,
        'mediumtext' => 16777215,
        'longtext'   => 4294967295,
    ];

    protected array $standardColumns = [
        ['name' => 'model_type',     'type' => 'string',   'limit' => 191, 'nullable' => true],
        ['name' => 'model_id',       'type' => 'integer',  'nullable' => true],
        ['name' => 'constructor_id', 'type' => 'integer',  'nullable' => true],
        ['name' => 'context_key',    'type' => 'string',   'limit' => 50, 'nullable' => false, 'default' => 'web'],
        ['name' => 'menuindex',      'type' => 'integer',  'nullable' => false, 'default' => 0],
        ['name' => 'published_at',   'type' => 'datetime', 'nullable' => true],
        ['name' => 'data',           'type' => 'json',     'nullable' => true],
    ];

    public function __construct()
    {
        $this->appPath        = MODX_CORE_PATH . 'App/';
        $this->migrationsPath = $this->appPath . 'Database/migrations/';
        $this->phinxBin       = $this->appPath . 'phinx';
        $this->phinxConfig    = $this->appPath . 'phinx.php';
        $this->phinxLogTable  = 'pb_app_migrations';
    }

    // ---------------------------------------------------------------
    // Public API
    // ---------------------------------------------------------------

    public function execute(PbMigration $migration)
    {
        if ($migration->status === 'executed') {
            abort(405, 'Migration cannot be executed in status: '. $migration->status);
        }

        if ($migration->migration_file) {
            $this->removeFile($this->migrationsPath . $migration->migration_file);
        }

        [$version, $filePath] = $this->generateFile($migration);

        try {
            $output = $this->runPhinx('migrate');
        } catch (\RuntimeException $e) {
            $this->removeFile($filePath);
            $migration->markAsFailed($e->getMessage());
            throw $e;
        }

        $batch = $this->nextBatch();
        $migration->markAsExecuted($batch, basename($filePath), $output);

        // Генерируем/обновляем модель и контроллер
        if (!in_array($migration->table_name, ['pb_table_data'])) {
            (new CodeGenerator())->generate($migration);
        }
    }

    public function rollback(PbMigration $migration): void
    {
        if ($migration->status !== 'executed') {
            abort(405, 'Only executed migrations can be rolled back.');
        }

        $version      = $this->extractVersion($migration->migration_file);
        $prevVersion  = $this->getPreviousVersion($version);

        // --target=X откатывает всё после X (не включая X)
        // Если предыдущей версии нет → откат к нулю
        $target = $prevVersion ?? '0';
        $output = $this->runPhinx('rollback', '--target=' . $target);

        $migration->rollback();
    }

    // ---------------------------------------------------------------
    // File generation
    // ---------------------------------------------------------------

    protected function generateFile(PbMigration $migration): array
    {
        $version   = date('YmdHis');
        $className = $this->buildClassName($migration);

        $this->removeFilesByClassName($className);

        $content   = $this->buildFileContent($migration, $className);
        $filename  = $version . '_' . $className . '.php';
        $filePath  = $this->migrationsPath . $filename;

        if (!is_dir($this->migrationsPath)) {
            mkdir($this->migrationsPath, 0755, true);
        }

        file_put_contents($filePath, $content);

        return [$version, $filePath];
    }

    protected function buildClassName(PbMigration $migration): string
    {
        $prefix = match ($migration->type) {
            'create_table'     => 'Create',
            'drop_table'       => 'Drop',
            'add_column'       => 'AddColumnTo',
            'change_column'    => 'ChangeColumnIn',
            'drop_column'      => 'DropColumnFrom',
            'rename_column'    => 'RenameColumnIn',
            'add_index'        => 'AddIndexTo',
            'drop_index'       => 'DropIndexFrom',
            'add_foreign_key'  => 'AddForeignKeyTo',
            'drop_foreign_key' => 'DropForeignKeyFrom',
            default            => 'Migrate',
        };

        $tablePascal = implode('', array_map('ucfirst', explode('_', $migration->table_name)));

        return $prefix . $tablePascal . 'Table';
    }

    protected function removeFilesByClassName(string $className): void
    {
        $pattern = $this->migrationsPath . '*_' . $className . '.php';
        foreach (glob($pattern) as $file) {
            unlink($file);
        }
    }

    protected function buildFileContent(PbMigration $migration, string $className): string
    {
        $body = match ($migration->type) {
            'create_table'     => $this->buildCreateTable($migration),
            'drop_table'       => $this->buildDropTable($migration),
            'add_column'       => $this->buildAddColumn($migration),
            'change_column'    => $this->buildChangeColumn($migration),
            'drop_column'      => $this->buildDropColumn($migration),
            'rename_column'    => $this->buildRenameColumn($migration),
            'add_index'        => $this->buildAddIndex($migration),
            'drop_index'       => $this->buildDropIndex($migration),
            default            => '        // TODO',
        };

        return <<<PHP
<?php

use Phinx\Migration\AbstractMigration;

class {$className} extends AbstractMigration
{
    public function change(): void
    {
{$body}
    }
}
PHP;
    }

    // ---------------------------------------------------------------
    // Migration type builders
    // ---------------------------------------------------------------

    protected function buildCreateTable(PbMigration $migration): string
    {
        $table   = $migration->table_name;
        $comment = $migration->table_comment
            ? ", 'comment' => " . var_export($migration->table_comment, true)
            : '';

        $lines = [];
        $lines[] = "        \$t = \$this->table('{$table}', ['id' => true, 'primary_key' => ['id']{$comment}]);";
        $lines[] = "        \$t";

        // Колонки пользователя
        foreach ($migration->columns as $col) {
            $lines[] = $this->columnLine($col);
        }

        // Стандартные колонки
        foreach ($this->standardColumns as $std) {
            $lines[] = $this->standardColumnLine($std);
        }

        // Timestamps + soft delete
        $lines[] = "            ->addTimestamps()";
        $lines[] = "            ->addColumn('deleted_at', 'datetime', ['null' => true])";

        // Стандартные индексы
        $lines[] = "            ->addIndex(['model_type', 'model_id'])";
        $lines[] = "            ->addIndex(['constructor_id'])";
        $lines[] = "            ->addIndex(['context_key'])";
        $lines[] = "            ->addIndex(['menuindex'])";
        $lines[] = "            ->addIndex(['published_at'])";

        // Индексы пользователя
        foreach ($migration->columns as $col) {
            if ($col->add_index) {
                $indexType = $this->resolveIndexType($col);
                $opts = match($indexType) {
                    'unique'   => ", ['unique' => true]",
                    'fulltext' => ", ['type' => 'fulltext']",
                    default    => '',
                };
                $lines[] = "            ->addIndex(['{$col->name}']{$opts})";
            }
        }

        $lines[] = "            ->create();";

        return implode("\n", $lines);
    }

    protected function resolveIndexType(object $col): string
    {
        $textTypes = ['text', 'tinytext', 'mediumtext', 'longtext', 'blob', 'varbinary', 'binary'];

        if (in_array($col->type, $textTypes) && $col->index_type !== 'unique') {
            return 'fulltext';
        }

        return $col->index_type ?? 'index';
    }

    protected function buildDropTable(PbMigration $migration): string
    {
        return "        \$this->table('{$migration->table_name}')->drop()->save();";
    }

    protected function buildAddColumn(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";
        $lines[] = "        \$t";

        foreach ($migration->columns as $col) {
            $lines[] = $this->columnLine($col);
        }

        foreach ($migration->columns as $col) {
            if ($col->add_index) {
                $opts    = $col->index_type === 'unique' ? ", ['unique' => true]" : '';
                $lines[] = "            ->addIndex(['{$col->name}']{$opts})";
            }
        }

        $lines[] = "            ->update();";

        return implode("\n", $lines);
    }

    protected function buildChangeColumn(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";
        $lines[] = "        \$t";

        foreach ($migration->columns as $col) {
            [$phinxType, $extraOpts] = $this->resolvePhinxType($col);
            $opts    = $this->buildOptions($col, $extraOpts);
            $lines[] = "            ->changeColumn('{$col->name}', '{$phinxType}', {$opts})";
        }

        $lines[] = "            ->update();";

        return implode("\n", $lines);
    }

    protected function buildDropColumn(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";
        $lines[] = "        \$t";

        foreach ($migration->columns as $col) {
            $lines[] = "            ->removeColumn('{$col->name}')";
        }

        $lines[] = "            ->update();";

        return implode("\n", $lines);
    }

    protected function buildRenameColumn(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";

        foreach ($migration->columns as $col) {
            if ($col->new_name) {
                $lines[] = "        \$t->renameColumn('{$col->name}', '{$col->new_name}')->update();";
            }
        }

        return implode("\n", $lines);
    }

    protected function buildAddIndex(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";
        $lines[] = "        \$t";

        foreach ($migration->columns as $col) {
            $opts    = $col->index_type === 'unique' ? ", ['unique' => true]" : '';
            $lines[] = "            ->addIndex(['{$col->name}']{$opts})";
        }

        $lines[] = "            ->update();";

        return implode("\n", $lines);
    }

    protected function buildDropIndex(PbMigration $migration): string
    {
        $lines   = [];
        $lines[] = "        \$t = \$this->table('{$migration->table_name}');";
        $lines[] = "        \$t";

        foreach ($migration->columns as $col) {
            $lines[] = "            ->removeIndex(['{$col->name}'])";
        }

        $lines[] = "            ->update();";

        return implode("\n", $lines);
    }

    // ---------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------

    protected function columnLine(object $col): string
    {
        [$phinxType, $extraOpts] = $this->resolvePhinxType($col);
        $opts = $this->buildOptions($col, $extraOpts);
        return "            ->addColumn('{$col->name}', '{$phinxType}', {$opts})";
    }

    protected function standardColumnLine(array $col): string
    {
        $options = ['null' => $col['nullable']];
        if (isset($col['default'])) { $options['default'] = $col['default']; }
        if (isset($col['limit']))   { $options['limit']   = $col['limit'];   }

        return "            ->addColumn('{$col['name']}', '{$col['type']}', " . $this->phpArray($options) . ")";
    }

    protected function resolvePhinxType(object $col): array
    {
        if (isset($this->textLimits[$col->type])) {
            return ['text', ['limit' => $this->textLimits[$col->type]]];
        }

        return [$col->type, []];
    }

    protected function buildOptions(object $col, array $extra = []): string
    {
        $opts = ['null' => (bool) $col->nullable];

        foreach ($extra as $k => $v) {
            $opts[$k] = $v;
        }

        $typesWithLimit = [
            'char', 'string', 'binary', 'varbinary',
            'tinyinteger', 'smallinteger', 'mediuminteger', 'integer', 'biginteger',
            'text',
        ];
        if ($col->length && in_array($col->type, $typesWithLimit)) {
            $opts['limit'] = (int) $col->length;
        }

        $typesWithPrecision = ['float', 'double', 'decimal'];
        if ($col->precision && in_array($col->type, $typesWithPrecision)) {
            $opts['precision'] = (int) $col->precision;
        }
        if ($col->scale && in_array($col->type, $typesWithPrecision)) {
            $opts['scale'] = (int) $col->scale;
        }

        if ($col->after) {
            $opts['after'] = $col->after;
        }
        if ($col->comment) {
            $opts['comment'] = $col->comment;
        }
        if ($col->default_value !== null && $col->default_value !== '') {
            $opts['default'] = $col->default_value;
        }

        $typesWithUnsigned = [
            'tinyinteger', 'smallinteger', 'mediuminteger', 'integer', 'biginteger',
            'float', 'double', 'decimal',
        ];
        if (!empty($col->unsigned) && in_array($col->type, $typesWithUnsigned)) {
            $opts['signed'] = false;
        }

        $typesWithAutoIncrement = [
            'tinyinteger', 'smallinteger', 'mediuminteger', 'integer', 'biginteger',
        ];
        if (!empty($col->auto_increment) && in_array($col->type, $typesWithAutoIncrement)) {
            $opts['identity'] = true;
        }

        if (!empty($col->on_update) && $col->type === 'timestamp') {
            $opts['update'] = 'CURRENT_TIMESTAMP';
        }

        if (in_array($col->type, ['enum', 'set']) && !empty($col->values)) {
            $values = is_string($col->values)
                ? array_map('trim', explode(',', $col->values))
                : $col->values;

            $opts['values'] = $values;
        }

        return $this->phpArray($opts);
    }

    protected function phpArray(array $arr): string
    {
        if (empty($arr)) {
            return '[]';
        }

        $parts = [];
        foreach ($arr as $k => $v) {
            $key = is_int($k) ? '' : "'{$k}' => ";

            if (is_bool($v)) {
                $parts[] = $key . ($v ? 'true' : 'false');
            } elseif (is_int($v)) {
                $parts[] = $key . $v;
            } elseif (is_array($v)) {
                $valuesStr = implode(', ', array_map(fn($val) => var_export($val, true), $v));
                $parts[] = $key . '[' . $valuesStr . ']';
            } else {
                $parts[] = $key . var_export($v, true);
            }
        }
        return '[' . implode(', ', $parts) . ']';
    }

    protected function runPhinx(string $command, string $extra = ''): string
    {
        if (!file_exists($this->phinxBin)) {
            abort(405, 'Phinx binary not found: ' . $this->phinxBin);
        }

        $cmd = sprintf(
            'php %s %s --configuration=%s --environment=production %s 2>&1',
            escapeshellarg($this->phinxBin),
            $command,
            escapeshellarg($this->phinxConfig),
            $extra
        );

        exec($cmd, $outputLines, $exitCode);
        $output = implode("\n", $outputLines);

        if ($exitCode !== 0) {
            abort(405, $output);
        }

        return $output;
    }

    protected function nextBatch(): int
    {
        return (int) query('pb_ui_migrations')->max('batch') + 1;
    }

    protected function extractVersion(string $filename): string
    {
        return explode('_', basename($filename, '.php'))[0];
    }

    protected function getPreviousVersion(string $version): ?string
    {
        $row = query($this->phinxLogTable)
            ->where('version', '<', $version)
            ->orderByDesc('version')
            ->first();

        return $row ? (string) $row->version : null;
    }

    protected function removeFile(string $path): void
    {
        if (file_exists($path)) {
            unlink($path);
        }
    }
}
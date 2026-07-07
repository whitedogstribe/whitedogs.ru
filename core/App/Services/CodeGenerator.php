<?php

namespace PageBlocks\App\Services;

use Boshnik\PageBlocks\Models\PbMigration;
use Illuminate\Support\Collection;

class CodeGenerator
{
    protected string $modelsPath;
    protected string $controllersPath;
    protected string $modelsNamespace      = 'PageBlocks\\App\\Models';
    protected string $controllersNamespace = 'PageBlocks\\App\\Http\\Controllers';
    protected string $baseModelsNamespace  = 'PageBlocks\\App\\Models\\Base';

    // Стандартные колонки — всегда присутствуют в create_table
    protected array $standardFillable = [
        'model_type',
        'model_id',
        'context_key',
        'constructor_id',
        'menuindex',
        'published_at',
        'data',
    ];

    // Колонки, которые НЕ идут в fillable
    protected array $skipFillable = [
        'id', 'created_at', 'updated_at', 'deleted_at',
    ];

    protected array $castMap = [
        'tinyinteger'  => 'int',
        'smallinteger' => 'int',
        'mediuminteger'=> 'int',
        'integer'      => 'int',
        'biginteger'   => 'int',
        'boolean'      => 'bool',
        'json'         => 'array',
        'decimal'      => 'float',
        'float'        => 'float',
        'double'       => 'float',
        'datetime'     => 'datetime',
        'timestamp'    => 'datetime',
        'date'         => 'date',
    ];

    public function __construct()
    {
        $appPath                = MODX_CORE_PATH . 'App/';
        $this->modelsPath       = $appPath . 'Models/';
        $this->controllersPath  = $appPath . 'Http/Controllers/';
    }

    // ---------------------------------------------------------------
    // Public API
    // ---------------------------------------------------------------

    public function generate(PbMigration $migration): void
    {
        if ($migration->type === 'drop_table') {
            // При удалении таблицы не трогаем файлы — пусть разработчик решает
            return;
        }

        $modelName = $migration->model_name ?: $this->tableToModelName($migration->table_name);
        $columns   = $this->resolveCurrentColumns($migration->table_name);

        $this->generateBaseModel($migration, $modelName, $columns);
        $this->generateModel($migration, $modelName);        // только если не существует
//        $this->generateController($migration, $modelName);   // только если не существует
    }

    // ---------------------------------------------------------------
    // Column resolution — вычисляем текущее состояние схемы
    // из всех выполненных миграций для этой таблицы
    // ---------------------------------------------------------------

    public function resolveCurrentColumns(string $tableName): Collection
    {
        $migrations = PbMigration::where('table_name', $tableName)
            ->where('status', 'executed')
            ->orderBy('id')
            ->with('columns')
            ->get();

        $columns = collect();

        foreach ($migrations as $migration) {
            switch ($migration->type) {
                case 'create_table':
                    $columns = $migration->columns->keyBy('name');
                    break;

                case 'add_column':
                    foreach ($migration->columns as $col) {
                        $columns->put($col->name, $col);
                    }
                    break;

                case 'drop_column':
                    foreach ($migration->columns as $col) {
                        $columns->forget($col->name);
                    }
                    break;

                case 'rename_column':
                    foreach ($migration->columns as $col) {
                        if ($col->new_name && $columns->has($col->name)) {
                            $existing       = $columns->pull($col->name);
                            $existing->name = $col->new_name;
                            $columns->put($col->new_name, $existing);
                        }
                    }
                    break;

                case 'change_column':
                    foreach ($migration->columns as $col) {
                        if ($columns->has($col->name)) {
                            $existing                 = $columns->get($col->name);
                            $existing->type           = $col->type;
                            $existing->nullable       = $col->nullable;
                            $existing->length         = $col->length;
                            $existing->unsigned       = $col->unsigned;
                            $existing->auto_increment = $col->auto_increment;
                            $existing->on_update      = $col->on_update;
                        }
                    }
                    break;
            }
        }

        return $columns->values();
    }

    // ---------------------------------------------------------------
    // BaseModel — всегда перезаписывается
    // ---------------------------------------------------------------

    protected function generateBaseModel(PbMigration $migration, string $modelName, Collection $columns): void
    {
        $fillable   = $this->buildFillable($columns);
        $casts      = $this->buildCasts($columns);
        $attributes = $this->buildAttributes($columns);

        $fillableCode   = $this->phpStringArray($fillable);
        $castsCode      = $this->phpAssocArray($casts);
        $attributesCode = $this->phpAssocArray($attributes);

        $tableName = $migration->table_name;

        $content = <<<PHP
<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit {$modelName}.php instead.

namespace {$this->baseModelsNamespace};

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class Base{$modelName} extends AbstractDataModel
{
    protected \$table = '{$tableName}';

    protected \$fillable = {$fillableCode};

    protected \$casts = {$castsCode};

    protected \$attributes = {$attributesCode};
}
PHP;

        $dir = $this->modelsPath . 'Base/';
        $this->ensureDir($dir);
        file_put_contents($dir . 'Base' . $modelName . '.php', $content);
    }

    // ---------------------------------------------------------------
    // Model — создаётся один раз
    // ---------------------------------------------------------------

    protected function generateModel(PbMigration $migration, string $modelName): void
    {
        $path = $this->modelsPath . $modelName . '.php';

        if (file_exists($path)) {
            return; // Не перезаписываем — пользователь мог добавить кастомный код
        }

        $tableName = $migration->table_name;

        $content = <<<PHP
<?php

namespace {$this->modelsNamespace};

use {$this->baseModelsNamespace}\\Base{$modelName};

class {$modelName} extends Base{$modelName}
{
    // Ваши кастомные методы, relations, scopes — здесь
    // Этот файл не будет перезаписан при изменениях схемы

    protected array \$copiableRelations = [];
}
PHP;

        $this->ensureDir($this->modelsPath);
        file_put_contents($path, $content);
    }

    // ---------------------------------------------------------------
    // Controller — создаётся один раз
    // ---------------------------------------------------------------

    protected function generateController(PbMigration $migration, string $modelName): void
    {
        $path = $this->controllersPath . $modelName . 'Controller.php';

        if (file_exists($path)) {
            return;
        }

        $tableName  = $migration->table_name;
        $modelFqcn  = $this->modelsNamespace . '\\' . $modelName;

        $content = <<<PHP
<?php

namespace {$this->controllersNamespace};

use Boshnik\PageBlocks\Http\Controllers\DataController;
use Boshnik\PageBlocks\Http\Request;
use {$modelFqcn};

class {$modelName}Controller extends DataController
{
    protected string \$table = '{$tableName}';
    protected string \$model = {$modelName}::class;

    public function rules(array \$data, ?int \$id = null): array
    {
        return [];
    }
}
PHP;

        $this->ensureDir($this->controllersPath);
        file_put_contents($path, $content);
    }

    // ---------------------------------------------------------------
    // Builders
    // ---------------------------------------------------------------

    protected function buildFillable(Collection $columns): array
    {
        $userColumns = $columns
            ->pluck('name')
            ->filter(fn($name) => !in_array($name, $this->skipFillable))
            ->values()
            ->toArray();

        // Стандартные колонки + пользовательские
        return array_values(array_unique([
            ...$this->standardFillable,
            ...$userColumns,
        ]));
    }

    protected function buildCasts(Collection $columns): array
    {
        $casts = [
            'menuindex'    => 'int',
            'published_at' => 'datetime',
            'data'         => 'array',
        ];

        foreach ($columns as $col) {
            if (isset($this->castMap[$col->type])) {
                $casts[$col->name] = $this->castMap[$col->type];
            }
        }

        // Убираем id, created_at и т.д.
        foreach ($this->skipFillable as $skip) {
            unset($casts[$skip]);
        }

        return $casts;
    }

    protected function buildAttributes(Collection $columns): array
    {
        $attributes = [
            'context_key' => 'web',
            'menuindex' => 0,
        ];

        foreach ($columns as $col) {
            if ($col->default_value !== null && $col->default_value !== '') {
                $value = match ($col->type) {
                    'tinyinteger',
                    'smallinteger',
                    'mediuminteger',
                    'integer',
                    'biginteger'  => (int)   $col->default_value,
                    'boolean'     => (bool)  $col->default_value,
                    'float',
                    'double',
                    'decimal'     => (float) $col->default_value,
                    default       => $col->default_value,
                };
                $attributes[$col->name] = $value;
            }
        }

        return $attributes;
    }

    // ---------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------

    protected function tableToModelName(string $tableName): string
    {
        return implode('', array_map('ucfirst', explode('_', $tableName)));
    }

    protected function phpStringArray(array $items): string
    {
        if (empty($items)) {
            return '[]';
        }

        $lines = array_map(fn($item) => "        '{$item}',", $items);
        return "[\n" . implode("\n", $lines) . "\n    ]";
    }

    protected function phpAssocArray(array $items): string
    {
        if (empty($items)) {
            return '[]';
        }

        $lines = array_map(
            fn($k, $v) => "        '{$k}' => " . var_export($v, true) . ',',
            array_keys($items),
            array_values($items)
        );

        return "[\n" . implode("\n", $lines) . "\n    ]";
    }

    protected function ensureDir(string $path): void
    {
        if (!is_dir($path)) {
            mkdir($path, 0755, true);
        }
    }
}
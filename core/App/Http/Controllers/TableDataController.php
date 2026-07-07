<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Controllers\DataController;
use Illuminate\Database\Query\Builder;
use PageBlocks\App\Models\PbTableData;
use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Services\CodeGenerator;

class TableDataController extends DataController
{
    public string $table = 'pb_table_data';
    public string $model = PbTableData::class;
    public string $constructorType = 'pbTable';
    protected int $filterConstructorId = 0;

    public function __construct(public \modX $modx, Request $request = null)
    {
        if ($request && $request->has('model')) {
            $this->model = 'PageBlocks\\App\\Models\\' . $request->model;
            $this->table = (new $this->model())->getTable();
        }
        if ($request) {
            $this->filterConstructorId = (int) $request->get('constructor_id', 0);
        }

        parent::__construct($this->modx);
    }

    public function extendQuery(Builder $query): Builder
    {
        if ($this->filterConstructorId > 0 && in_array('constructor_id', $this->columns)) {
            $query->where('constructor_id', $this->filterConstructorId);
        }
        return $query;
    }

    protected function prepareData(array $data, array $rules = []): array
    {
        // Capture non-column fields BEFORE parent may strip anything
        $skip = ['HTTP_MODAUTH', 'ctx', 'id', 'model', 'primary_table', '_dc',
                 'model_type', 'model_id', 'context_key', 'constructor_id', 'field_id',
                 'parent_type', 'parent_id', 'menuindex', 'published_at', 'created_at', 'updated_at'];
        $extra = [];
        if (in_array('data', $this->columns)) {
            foreach ($data as $key => $value) {
                if (!in_array($key, $this->columns) && !in_array($key, $skip)) {
                    $extra[$key] = $value;
                }
            }
        }

        $data = parent::prepareData($data, $rules);

        if (in_array('data', $this->columns) && !empty($extra)) {
            // Load existing data from DB so untouched fields are preserved
            $recordId = (int) ($data['id'] ?? 0);
            $existing = [];
            if ($recordId > 0) {
                $row = query($this->table)->where('id', $recordId)->first(['data']);
                if ($row !== null) {
                    $existing = is_array($row->data)
                        ? $row->data
                        : (json_decode($row->data, true) ?? []);
                }
            }

            // Remove null/empty values from $extra so they don't wipe existing data
            $extra = array_filter($extra, fn($v) => $v !== null && $v !== '');

            $data['data'] = array_merge($existing, $extra);
        }

        // Strip keys not present in the model's table to prevent SQL errors
        // (e.g. constructor_id sent from form but absent from modx_blog_posts)
        $data = array_intersect_key($data, array_flip($this->columns));

        return $data;
    }

    public function update(int $id, Request $request)
    {
        $data = $request->all();
        $rules = $this->rules($data, $id);
        $data = $this->prepareData($data, $rules);

        // Use raw query to bypass AbstractDataModel::saving which zeroes out data
        // when it finds no matching pb_fields for custom keys like rent_ids
        $updateColumns = [];
        foreach ($data as $key => $value) {
            if (in_array($key, $this->columns) && $key !== 'id' && $key !== 'data') {
                $updateColumns[$key] = $value;
            }
        }
        if (isset($data['data'])) {
            $updateColumns['data'] = json_encode($data['data'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        }
        if (!empty($updateColumns)) {
            $updateColumns['updated_at'] = date('Y-m-d H:i:s');
            query($this->table)->where('id', $id)->update($updateColumns);
        }

        $validated = $request->validate($rules);
        return response()->append([
            'total' => 1,
            'data'   => $validated,
            'object' => [],
        ])->success('Object successfully updated');
    }

    public function rules(array $data, ?int $id = null): array
    {
        $columns = (new CodeGenerator())->resolveCurrentColumns($this->table);
        $rules = [];

        foreach ($columns as $col) {
            $hasDefault = $col->default_value !== null && $col->default_value !== '';

            if ($col->nullable || $hasDefault) {
                $colRules = ['nullable'];
            } else {
                $colRules = ['required'];
            }

            $colRules[] = match($col->type) {
                'tinyinteger', 'smallinteger', 'mediuminteger', 'integer', 'biginteger' => 'integer',
                'float', 'double', 'decimal' => 'numeric',
                'boolean' => 'boolean',
                'datetime', 'timestamp', 'date' => 'date',
                'json' => 'array',
                'string', 'char' => $col->length ? 'max:' . $col->length : 'string',
                default => 'string',
            };

            $rules[$col->name] = $colRules;
        }

        return $rules;
    }

    public function import(Request $request)
    {
        $items = json_decode($request->content, true);
        foreach ($items as $idx => $item) {
            $this->createTable([
                'model_type' => $request->model_type,
                'model_id' => $request->model_id,
                'context_key' => $request->context_key,
                'constructor_id' => $request->constructor_id,
                'field_id' => $request->field_id,
                'data' => json_encode($item, JSON_UNESCAPED_UNICODE),
                'menuindex' => $idx
            ]);
        }
    }

    protected function createTable($data)
    {
        query($this->table)->insert($data);
    }

    protected function prepareArray(array $array = [], $constructor_id = null): array
    {
        if ($this->table === 'tours' && !empty($array['id'])) {
            $file = query('pb_files')
                ->where('model_id', $array['id'])
                ->where('model_type', 'PageBlocks\App\Models\Tour')
                ->whereNotNull('published_at')
                ->where('published_at', '<=', now())
                ->orderBy('menuindex')
                ->first(['url', 'name', 'extension', 'width', 'height', 'size']);

            if ($file) {
                $array['img'] = json_encode([
                    'url'   => $file->url,
                    'title' => $file->name . '.' . $file->extension,
                    'width' => $file->width,
                    'height'=> $file->height,
                    'size'  => $file->size,
                    'type'  => 'image',
                ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
            }
        }

        return parent::prepareArray($array, $constructor_id);
    }
}
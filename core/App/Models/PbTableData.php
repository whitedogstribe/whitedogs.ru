<?php


namespace PageBlocks\App\Models;

use Boshnik\PageBlocks\Models\AbstractDataModel;
use Boshnik\PageBlocks\Models\PbTable;

class PbTableData extends AbstractDataModel
{
    protected $table = 'pb_table_data';

    protected $fillable = [
        'model_type',
        'model_id',
        'parent_type',
        'parent_id',
        'context_key',
        'constructor_id',
        'field_id',
        'data',
        'menuindex',
        'published_at',
    ];

    protected $casts = [
        'data' => 'array',
        'model_id' => 'integer',
        'parent_id' => 'integer',
        'constructor_id' => 'integer',
        'field_id' => 'integer',
        'menuindex' => 'integer',
        'published_at' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    public function scopeByField($query, int $fieldId)
    {
        return $query->where('field_id', $fieldId);
    }

    public function constructor()
    {
        return $this->belongsTo(PbTable::class, 'constructor_id');
    }

    public function blocks()
    {
        return $this->hasMany(PbBlockData::class, 'model_id', 'id')
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->orderBy('menuindex');
    }

    public function tables()
    {
        return $this->hasMany(PbTableData::class, 'model_id', 'id')
            ->where('model_type', self::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->orderBy('menuindex');
    }

    public function images()
    {
        return $this->hasMany(PbFile::class, 'model_id', 'id')
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex');
    }

    public function parent()
    {
        return $this->morphTo('model', 'model_type', 'model_id');
    }

    public function tour()
    {
        return $this->belongsTo(Tour::class, 'model_id', 'id');
    }
}
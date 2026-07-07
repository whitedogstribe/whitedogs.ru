<?php

namespace PageBlocks\App\Models;

use Boshnik\PageBlocks\Models\AbstractDataModel;
use Boshnik\PageBlocks\Models\PbBlock;
use Boshnik\PageBlocks\Models\PbField;

class PbBlockData extends AbstractDataModel
{
    protected $table = 'pb_block_data';
    protected string $constructorType = 'pbBlock';

    protected $fillable = [
        'ready_block_desc',
        'model_type',
        'model_id',
        'parent_type',
        'parent_id',
        'context_key',
        'constructor_id',
        'readyblock_id',
        'utm_id',
        'utm_name',
        'block_name',
        'chunk',
        'data',
        'menuindex',
        'published_at',
    ];

    protected $casts = [
        'data'        => 'array',
        'model_id'    => 'integer',
        'parent_id'   => 'integer',
        'constructor_id' => 'integer',
        'readyblock_id'  => 'integer',
        'utm_id'      => 'integer',
        'menuindex'   => 'integer',
        'published_at' => 'datetime',
        'created_at'  => 'datetime',
        'updated_at'  => 'datetime',
        'deleted_at'  => 'datetime',
    ];

    protected $attributes = [
        'parent_id' => 0,
        'readyblock_id' => 0,
        'utm_id' => 0,
    ];

    public function constructor(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(PbBlock::class, 'constructor_id');
    }

    public function fields(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PbField::class, 'model_id', 'constructor_id')
            ->where('model_type', 'pbBlock')
            ->active()
            ->notDeleted();
    }

    public function readyBlock(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(PbBlockData::class, 'readyblock_id');
    }

    public function render(): string
    {
        return view('file:chunks/' . $this->chunk, $this->toArray());
    }

    public function children(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(PbBlockData::class, 'parent', 'parent_type', 'parent_id');
    }
}
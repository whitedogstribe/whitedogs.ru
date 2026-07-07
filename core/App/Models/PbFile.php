<?php

namespace PageBlocks\App\Models;

use Boshnik\PageBlocks\Facades\Glide;
use Boshnik\PageBlocks\Models\BaseModel;

class PbFile extends BaseModel
{
    protected $table = 'pb_files';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'field_id',
        'source',
        'source_path',
        'filename',
        'extension',
        'name',
        'title',
        'description',
        'type',
        'width',
        'height',
        'size',
        'url',
        'groups',
        'menuindex',
        'properties',
        'published_at',
    ];

    protected $casts = [
        'model_id'     => 'integer',
        'field_id'     => 'integer',
        'source'       => 'integer',
        'width'        => 'integer',
        'height'       => 'integer',
        'size'         => 'integer',
        'menuindex'    => 'integer',
        'properties'   => 'array',
        'published_at' => 'datetime',
        'created_at'   => 'datetime',
        'updated_at'   => 'datetime',
    ];

    // ------------------------------------------------------------------
    // Scopes
    // ------------------------------------------------------------------

    public function scopeOfType($query, string $type)
    {
        return $query->where('type', $type);
    }

    public function scopeForModel($query, string $type, int $id)
    {
        return $query->where('model_type', $type)->where('model_id', $id);
    }

    public function getThumbAttribute(): string
    {
        if ($this->type !== 'image') {
            return '/' . $this->url;
        }

        return Glide::url($this->url, 'w=100&h=80&fit=crop&fm=webp&q=85');
    }

    public function getIsImageAttribute(): bool
    {
        return $this->type === 'image';
    }

    public function getIsVideoAttribute(): bool
    {
        return $this->type === 'video';
    }
}
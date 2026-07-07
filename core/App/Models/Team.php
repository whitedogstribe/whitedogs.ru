<?php

namespace PageBlocks\App\Models;

use PageBlocks\App\Models\Base\BaseTeam;

class Team extends BaseTeam
{
    protected array $copiableRelations = [];

    public function tours()
    {
        return $this->belongsToMany(Tour::class, 'tour_authors', 'author_id', 'model_id')
            ->withPivot('menuindex')
            ->orderBy('tour_authors.menuindex');
    }

    public function gallery()
    {
        return $this->hasMany(PbFile::class, 'model_id', 'id')
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex');
    }

    public function getImageAttribute()
    {
        return $this->avatar ?? '';
    }
}
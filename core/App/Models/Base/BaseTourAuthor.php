<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit TourAuthor.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseTourAuthor extends AbstractDataModel
{
    protected $table = 'tour_authors';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'published_at',
        'data',
        'author_id',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'author_id' => 'int',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
    ];
}
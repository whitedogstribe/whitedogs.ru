<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit TourLevel.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseTourLevel extends AbstractDataModel
{
    protected $table = 'tour_level';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'published_at',
        'data',
        'name',
        'level',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'level' => 'float',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
    ];
}
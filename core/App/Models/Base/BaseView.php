<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit View.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseView extends AbstractDataModel
{
    protected $table = 'views';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'published_at',
        'data',
        'viewed_at',
        'count',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'viewed_at' => 'date',
        'count' => 'int',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
        'count' => 1,
    ];
}
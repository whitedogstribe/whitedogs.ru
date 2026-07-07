<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit Country.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseCountry extends AbstractDataModel
{
    protected $table = 'countries';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'constructor_id',
        'menuindex',
        'published_at',
        'data',
        'name',
        'alias',
        'iso',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
    ];
}
<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit Tours.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseTour extends AbstractDataModel
{
    protected $table = 'tours';

    protected $fillable = [
        'model_type',
        'model_id',
        'constructor_id',
        'menuindex',
        'published_at',
        'data',
        'author_id',
        'context_key',
        'title',
        'alias',
        'img',
        'country_id',
        'city_id',
        'level',
        'type_tour',
        'altitude',
        'distance',
        'content',
        'countries',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'countries' => 'array',
        'author_id' => 'int',
        'country_id' => 'int',
        'city_id' => 'int',
        'level' => 'float',
        'altitude' => 'int',
        'distance' => 'int',
    ];

    protected $attributes = [
        'menuindex' => 0,
        'author_id' => 0,
        'context_key' => 'web',
        'country_id' => 0,
        'city_id' => 0,
        'level' => 1.0,
    ];
}
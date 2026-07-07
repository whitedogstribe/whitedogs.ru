<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit TourDate.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseTourDate extends AbstractDataModel
{
    protected $table = 'tour_dates';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'published_at',
        'data',
        'start_date',
        'end_date',
        'price',
        'currency',
        'price_usd',
        'discount',
        'discount_people',
        'people',
        'max_people',
        'status',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'start_date' => 'date',
        'end_date' => 'date',
        'price' => 'float',
        'price_usd' => 'float',
        'discount' => 'int',
        'discount_people' => 'int',
        'people' => 'int',
        'max_people' => 'int',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
        'price' => 0.0,
        'currency' => '$',
        'price_usd' => 0.0,
        'discount' => 0,
        'discount_people' => 0,
        'people' => 0,
        'max_people' => 0,
        'status' => 'open',
    ];
}
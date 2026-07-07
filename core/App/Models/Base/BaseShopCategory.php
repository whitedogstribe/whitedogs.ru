<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit ShopCategory.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseShopCategory extends AbstractDataModel
{
    protected $table = 'shop_categories';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'constructor_id',
        'menuindex',
        'published_at',
        'data',
        'title',
        'alias',
        'longtitle',
        'description',
        'content',
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
<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit Product.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseProduct extends AbstractDataModel
{
    protected $table = 'products';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'constructor_id',
        'published_at',
        'data',
        'title',
        'alias',
        'article',
        'description',
        'content',
        'price',
        'old_price',
        'deposit',
        'weight',
        'size',
        'rental_prices',
        'tags',
        'images',
        'quantity',
        'rent',
        'popular',
        'is_new',
        'on_sale',
        'in_stock',
        'featured',
        'category_id',
        'brand',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'price' => 'float',
        'old_price' => 'float',
        'deposit' => 'float',
        'weight' => 'float',
        'size' => 'array',
        'rental_prices' => 'array',
        'tags' => 'array',
        'images' => 'array',
        'quantity' => 'int',
        'rent' => 'bool',
        'popular' => 'bool',
        'is_new' => 'bool',
        'on_sale' => 'bool',
        'in_stock' => 'bool',
        'featured' => 'bool',
        'category_id' => 'int',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
        'price' => 0.0,
        'old_price' => 0.0,
        'deposit' => 0.0,
        'quantity' => 0,
        'rent' => false,
        'popular' => false,
        'is_new' => false,
        'on_sale' => false,
        'in_stock' => false,
        'featured' => false,
    ];
}
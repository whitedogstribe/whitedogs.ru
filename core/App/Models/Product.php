<?php

namespace PageBlocks\App\Models;

use PageBlocks\App\Models\Base\BaseProduct;

class Product extends BaseProduct
{
    // Ваши кастомные методы, relations, scopes — здесь
    // Этот файл не будет перезаписан при изменениях схемы

    protected array $copiableRelations = [];

    public function category()
    {
        return $this->belongsTo(ShopCategory::class);
    }

    public function gallery()
    {
        return $this->hasMany(
            PbFile::class,
            'model_id',
            'id',
        )
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex');

    }

    public function image()
    {
        return $this->hasOne(PbFile::class, 'model_id', 'id')
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex');
    }

    // Scopes

    public function scopeInStock($query)
    {
        return $query->where('in_stock', true);
    }

    public function scopePopular($query)
    {
        return $query->where('popular', true);
    }

    public function scopeNew($query)
    {
        return $query->where('is_new', true);
    }

    public function scopeOnSale($query)
    {
        return $query->where('on_sale', true);
    }

    public function scopeFeatured($query)
    {
        return $query->where('featured', true);
    }

    public function scopeByAlias($query, $alias)
    {
        return $query->where('alias', $alias);
    }

    public function scopeByCategory($query, $alias)
    {
        return $query->whereHas('category', function($q) use ($alias) {
            $q->where('alias', $alias);
        });
    }

    // Attributes
    public function getPriceFormatAttribute(): string
    {
        return $this->rent
            ? 'от ' . number_format($this->price, 0, '', ' ') . '$ / в день'
            : number_format($this->price, 0, '', ' ') . '$';
    }
}
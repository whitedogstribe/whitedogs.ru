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

    public function getOne(string $class, array $criteria = [])
    {
        if ($class === 'ContentType') {
            return new class {
                public function get($key) {
                    return $key === 'binary' ? false : 'text/html';
                }
                public function getmime() { return 'text/html'; }
            };
        }
        if ($class === 'Template') {
            return null;
        }
        return null;
    }

    public function prepare() {
        if (!isset($this->_output)) {
            $this->_output = '';
        }
    }

    public function __call($method, $parameters)
    {
        // Intercept xPDO-style scalar get($field) calls from MODX core
        if ($method === 'get' && count($parameters) === 1 && is_string($parameters[0])) {
            return $this->getAttribute($parameters[0]);
        }
        return parent::__call($method, $parameters);
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
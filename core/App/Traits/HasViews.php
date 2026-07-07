<?php

namespace PageBlocks\App\Traits;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use PageBlocks\App\Models\Views;

trait HasViews
{
    public function views(): MorphMany
    {
        return $this->morphMany(Views::class, 'model');
    }

    public function recordView(): void
    {
        $key = 'viewed_' . static::class . '_' . $this->getKey();

        if ($_SESSION[$key]) {
            return;
        }

        $_SESSION[$key] = true;

        DB::statement('
            INSERT INTO modx_views (model_type, model_id, viewed_at, created_at, updated_at)
            VALUES (?, ?, CURDATE(), NOW(), NOW())
            ON DUPLICATE KEY UPDATE 
                count      = count + 1, 
                updated_at = NOW()
        ', [static::class, (int) $this->getKey()]);

        $this->increment('views');
    }

    public function getViewsCountAttribute(): int
    {
        return $this->views()->sum('count');
    }

    public function getViewsForPeriod(string $from, string $to): int
    {
        return $this->views()
            ->whereBetween('viewed_at', [$from, $to])
            ->sum('count');
    }

    public function scopeOrderByViews($query, string $direction = 'desc')
    {
        return $query->orderBy('views', $direction);
    }
}
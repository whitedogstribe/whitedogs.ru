<?php

namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use PageBlocks\App\Models\Base\BaseTourDate;

class TourDate extends BaseTourDate
{
    protected array $copiableRelations = [];

    public function getStartDateAttribute($value): ?string
    {
        if (!$value || $value === '0000-00-00') return null;
        return $value instanceof \Carbon\Carbon ? $value->toDateString() : $value;
    }

    public function getEndDateAttribute($value): ?string
    {
        if (!$value || $value === '0000-00-00') return null;
        return $value instanceof \Carbon\Carbon ? $value->toDateString() : $value;
    }

    public function tour(): BelongsTo
    {
        return $this->belongsTo(Tour::class);
    }

    protected static function booted()
    {
        parent::boot();

        static::saving(function ($tourDate) {
            if ($tourDate->people >= $tourDate->max_people) {
                $tourDate->status = 'closed';
            }
        });
    }

    public function scopeInMonth($query, int $year, int $month)
    {
        return $query->whereYear('start_date', $year)
            ->whereMonth('start_date', $month);
    }

    public function scopeInDateRange($query, $startDate, $endDate)
    {
        return $query->where(function ($q) use ($startDate, $endDate) {
            $q->whereBetween('start_date', [$startDate, $endDate])
                ->orWhereBetween('end_date', [$startDate, $endDate])
                ->orWhere(function ($q2) use ($startDate, $endDate) {
                    $q2->where('start_date', '<=', $startDate)
                        ->where('end_date', '>=', $endDate);
                });
        });
    }

    public function getDateRangeAttribute(): string
    {
        return self::formatDateRange($this->start_date, $this->end_date);
    }

    public function getOldPriceFormatAttribute(): string
    {
        return $this->price > 0
            ? number_format($this->price, 0, '', ' ') . $this->currency
            : number_format($this->price_usd, 0, '', ' ') . '$';
    }

    public function getPriceFormatAttribute(): string
    {
        if ($this->price > 0) {
            $raw = $this->price;
            $discounted = $this->discount > 0
                ? $raw - ($raw * $this->discount / 100)
                : $raw;

            return number_format($discounted, 0, '', ' ') . $this->currency;
        }

        $raw = $this->price_usd;
        $discounted = $this->discount > 0
            ? $raw - ($raw * $this->discount / 100)
            : $raw;

        return number_format($discounted, 0, '', ' ') . '$';
    }

    public function getClearPriceAttribute(): string
    {
        $raw = $this->price_usd;
        if ($this->price > 0) {
            $raw = $this->price;
        }

        $price = $this->discount > 0
            ? $raw - ($raw * $this->discount / 100)
            : $raw;

        return (int) $price;
    }

    public function getPlacesLeftAttribute(): string
    {
        return $this->max_people - $this->people;
    }

    public static function formatDateRange($startDate, $endDate, $locale = 'ru'): string
    {
        if (empty($startDate) || empty($endDate)) {
            return '';
        }

        $start = strtotime($startDate);
        $end = strtotime($endDate);

        $startDay = date('d', $start);
        $endDay = date('d', $end);
        $startMonth = date('F', $start);
        $endMonth = date('F', $end);
        $startYear = date('Y', $start);
        $endYear = date('Y', $end);

        $months = [
            'January' => 'января',    'February' => 'февраля',
            'March' => 'марта',      'April' => 'апреля',
            'May' => 'мая',          'June' => 'июня',
            'July' => 'июля',        'August' => 'августа',
            'September' => 'сентября','October' => 'октября',
            'November' => 'ноября',  'December' => 'декабря',
        ];

        if ($locale === 'ru') {
            $startMonth = $months[$startMonth];
            $endMonth = $months[$endMonth];
        }

        if (date('Y-m', $start) === date('Y-m', $end)) {
            return ltrim($startDay, '0') . '-' . ltrim($endDay, '0') . ' ' . $startMonth . ' ' . $startYear;
        }

        if ($startYear === $endYear) {
            return ltrim($startDay, '0') . ' ' . $startMonth . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $startYear;
        }

        return ltrim($startDay, '0') . ' ' . $startMonth . ' ' . $startYear . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $endYear;
    }
}
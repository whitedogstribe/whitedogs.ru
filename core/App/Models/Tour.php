<?php

namespace PageBlocks\App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use PageBlocks\App\Models\Base\BaseTour;

class Tour extends BaseTour
{

    protected $appends = ['country_name', 'city_name', 'date_range', 'class_key'];

    public function getClassKeyAttribute(): string
    {
        return static::class;
    }

    protected static function boot()
    {
        parent::boot();

        static::created(function ($model) {
            if ($model->is_replicated ?? false) {
                $originalId = $model->original_id;
                $original = static::find($originalId);

                if ($original) {
                    $dates = $original->dates()->get();
                    foreach ($dates as $date) {
                        $clonedDate = $date->replicate();
                        $clonedDate->model_id = $model->id;
                        $clonedDate->model_type = $model->getMorphClass();
                        $clonedDate->save();
                    }
                }
            }
        });
    }

    public function images()
    {
        return $this->hasMany(PbFile::class, 'model_id', 'id')
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

    public function dates()
    {
        return $this->hasMany(
            TourDate::class,
            'model_id',
            'id',
        )
            ->where('model_type', $this::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            //->where('status', 'open')
            ->orderBy('start_date');
    }

    public function plan()
    {
        return $this->hasMany(
            PbTableData::class,
            'model_id',
            'id',
        )
            ->where('model_type', $this::class)
            ->where('field_id', 253)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->select('data')
            ->orderBy('menuindex');
    }

    public function backpack()
    {
        return $this->hasMany(
            PbTableData::class,
            'model_id',
            'id',
        )
            ->where('model_type', $this::class)
            ->where('field_id', 279)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->select('data')
            ->orderBy('menuindex');
    }

    public function reviews()
    {
        return $this->hasMany(
            PbTableData::class,
            'model_id',
            'id',
        )
            ->where([
                'constructor_id' => 23,
                'field_id' => 276,
            ])
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->select('id', 'data', 'model_id')
            ->orderBy('menuindex');
    }

    public function faq()
    {
        return $this->hasMany(
            PbTableData::class,
            'model_id',
            'id',
        )
            ->where('model_type', $this::class)
            ->where('field_id', 330)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->select('data')
            ->orderBy('menuindex');

    }

    public function authors()
    {
        return $this->belongsToMany(Team::class, 'tour_authors', 'model_id', 'author_id')
            ->withPivot('menuindex')
            ->orderBy('tour_authors.menuindex');
    }

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class, 'country_id');
    }

    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class, 'city_id');
    }

    public function getCountryNameAttribute()
    {
        return $this->country?->name;
    }

    public function getCityNameAttribute()
    {
        return $this->city?->name;
    }

    public function getTypesAttribute()
    {
        return $this->type_tour ?? [];
    }

    public function scopeOpen($query, $filters = [])
    {
        $now = Carbon::now()->format('Y-m-d');
        $table = (new TourDate())->getTable();

        $nearest = TourDate::query()
            ->whereNotNull("{$table}.published_at")
            ->where("{$table}.published_at", '<=', now())
            ->where("{$table}.start_date", '>=', $now)
            ->orderBy("{$table}.start_date")
            ->groupBy("{$table}.model_id");

        return $query
            ->joinSub($nearest, 'nd', 'nd.model_id', '=', 'tours.id')
            ->where('nd.status', '!=', 'closed')
            ->when(!empty($filters['date_from']) && !empty($filters['date_to']), fn($q) =>
            $q->where('nd.start_date', '<=', $filters['date_to'])
                ->where('nd.end_date', '>=', $filters['date_from'])
            )
            ->when(!empty($filters['people']), fn($q) =>
            $q->where('nd.people', '>=', $filters['people'])
            )
            ->orderBy('nd.start_date')
            ->select('tours.*');
    }

    public function scopeWithDateRange($query, $dateFrom, $dateTo)
    {
        $from = is_numeric($dateFrom)
            ? Carbon::createFromTimestamp($dateFrom)->format('Y-m-d')
            : $dateFrom;

        $to = is_numeric($dateTo)
            ? Carbon::createFromTimestamp($dateTo)->format('Y-m-d')
            : $dateTo;

        return $query->whereHas('nearestDate', function ($q) use ($from, $to) {
            $q->where('start_date', '<=', $to)
                ->where('end_date', '>=', $from);
        });
    }

    public function scopeWithMinPeople($query, $minPeople)
    {
        return $query->whereHas('nearestDate', function ($q) use ($minPeople) {
            $q->where('people', '>=', $minPeople);
        });
    }

    public function scopeWithTypeTour($query, $types)
    {
        if (empty($types)) {
            return $query;
        }

        $types = is_array($types) ? $types : [$types];

        return $query->where(function ($q) use ($types) {
            foreach ($types as $type) {
                $q->orWhereJsonContains('type_tour', $type);
            }
        });
    }

    public function scopeByCountry($query, $countryAlias)
    {
        return $query->whereHas('country', function ($q) use ($countryAlias) {
            $q->where('alias', $countryAlias)
                ->orWhereJsonContains('countries', $countryAlias);
        });
    }

    public function scopeByType($query, $typeAliases)
    {
        if (empty($typeAliases)) {
            return $query;
        }

        $typeAliases = is_array($typeAliases) ? $typeAliases : [$typeAliases];

        return $query->where(function ($q) use ($typeAliases) {
            foreach ($typeAliases as $alias) {
                $q->orWhereJsonContains('type_tour', $alias);
            }
        });
    }

    public function scopeByAuthor($query, $authorIdentifier)
    {
        return $query->whereHas('authors', function ($q) use ($authorIdentifier) {
            if (is_numeric($authorIdentifier)) {
                $q->where('team.id', $authorIdentifier);
            } else {
                $q->where('team.alias', $authorIdentifier);
            }
        });
    }

    public function scopeByPrice($query, $min = null, $max = null)
    {
        $now = \Carbon\Carbon::now()->format('Y-m-d');
        return $query->whereHas('dates', function ($q) use ($min, $max, $now) {
            $q->whereNotNull('published_at')
              ->where('published_at', '<=', now())
              ->where('start_date', '>=', $now);
            if ($min !== null) $q->where('price_usd', '>=', (int)$min);
            if ($max !== null) $q->where('price_usd', '<=', (int)$max);
        });
    }

    public function scopeByDays($query, $min = null, $max = null)
    {
        if ($min !== null) {
            $query->whereRaw("CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.days')) AS UNSIGNED) >= ?", [(int)$min]);
        }
        if ($max !== null) {
            $query->whereRaw("CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.days')) AS UNSIGNED) <= ?", [(int)$max]);
        }
        return $query;
    }

    public function scopeOrderByPrice($query, $direction = 'asc')
    {
        $now = Carbon::now()->format('Y-m-d');
        $subQuery = TourDate::selectRaw('price_usd')
            ->whereColumn('model_id', 'tours.id')
            ->where('model_type', 'PageBlocks\\App\\Models\\Tour')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->where('start_date', '>=', $now)
            ->orderBy('start_date', 'asc')
            ->limit(1);

        return $query
            ->orderBy($subQuery, $direction)
            ->select('tours.*');
    }

    public function scopeOrderByDuration($query, $direction = 'asc')
    {
        $now = Carbon::now()->format('Y-m-d');

        $subQuery = TourDate::selectRaw('DATEDIFF(end_date, start_date)')
            ->whereColumn('model_id', 'tours.id')
            ->where('model_type', static::class)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->where('start_date', '>=', $now)
            ->orderBy('start_date', 'asc')
            ->limit(1);

        return $query
            ->orderBy($subQuery, $direction)
            ->select('tours.*');
    }

    public function scopeOrderByDate($query, $direction = 'asc')
    {
        $subQuery = TourDate::selectRaw('MIN(start_date)')
            ->whereColumn('model_id', 'tours.id')
            ->where('model_type', static::class)
//            ->where('status', 'open')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now());

        return $query
            ->orderBy($subQuery, $direction)
            ->select('tours.*');
    }

    public function scopeOrderOpenByDate($query, $direction = 'asc')
    {
        $subQuery = TourDate::selectRaw('MIN(start_date)')
            ->whereColumn('model_id', 'tours.id')
            ->where('model_type', static::class)
            ->where('status', 'open')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now());

        return $query
            ->orderBy($subQuery, $direction)
            ->select('tours.*');
    }

    public function scopeHasDates($query)
    {
        return $query->whereHas('dates');
    }

    public function nearestDate()
    {
        $now = Carbon::now()->format('Y-m-d');

        return $this->hasOne(TourDate::class, 'model_id', 'id')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
//            ->where('status', 'open')
            ->orderBy('start_date');
    }

    public function getGuideAttribute(): string
    {
        $author = $this->authors()->first();
        return $author?->name ?? '';
    }

    public function getDateRangeAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return self::formatDateRange($date->start_date, $date->end_date);
    }

    public function getStartDateAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->start_date;
    }

    public function getEndDateAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->end_date;
    }

    public function getDateRangeSimpleAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return self::formatDateRange($date->start_date, $date->end_date, 'ru', false);
    }

    public function getStatusAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->status;
    }

    public function getDaysCountAttribute(): int
    {
        $date = $this->nearestDate;

        if (!$date) {
            return 0;
        }

        return Carbon::parse($date->start_date)->diffInDays(Carbon::parse($date->end_date)) + 1;
    }

    public function getOldPriceAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->price > 0
            ? number_format($date->price, 0, '', ' ') . $date->currency
            : number_format($date->price_usd, 0, '', ' ') . '$';
    }

    public function getPriceAttribute(): string
    {

        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        if ($date->price > 0) {
            $raw = $date->price;
            $discounted = $date->discount > 0
                ? $raw - ($raw * $date->discount / 100)
                : $raw;

            return number_format($discounted, 0, '', ' ') . $date->currency;
        }

        $raw = $date->price_usd;
        $discounted = $date->discount > 0
            ? $raw - ($raw * $date->discount / 100)
            : $raw;

        return number_format($discounted, 0, '', ' ') . '$';
    }

    public function getClearPriceAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        $raw = $date->price_usd;
        if ($date->price > 0) {
            $raw = $date->price;
        }

        return $date->discount > 0
            ? $raw - ($raw * $date->discount / 100)
            : $raw;
    }

    public function getCurrencyAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->currency;
    }

    public function getDiscountAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->discount;
    }

    public function getPlacesLeftAttribute(): string
    {
        $date = $this->nearestDate;

        if (!$date) {
            return '';
        }

        return $date->max_people - $date->people;
    }

    public function getIsSoldOutAttribute(): bool
    {
        $date = $this->nearestDate;

        if (!$date) {
            return false;
        }

        if (!$date->max_people) {
            return false;
        }

        return ($date->max_people - $date->people) <= 0;
    }

    public static function formatDateRange($startDate, $endDate, $locale = 'ru', $year = true): string
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
            return ltrim($startDay, '0') . '-' . ltrim($endDay, '0') . ' ' . $startMonth . ' ' . ($year ? $startYear : '');
        }

        if ($startYear === $endYear) {
            return ltrim($startDay, '0') . ' ' . $startMonth . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . ($year ? $startYear : '');
        }

        return ltrim($startDay, '0') . ' ' . $startMonth . ' ' . $startYear . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $endYear;
    }

    public static function groupedByYearAndMonth($query = null, string $sortby = '', string $sortdir = 'asc'): array
    {
        $tours = ($query ?? static::query())
            ->whereHas('dates')
            ->with('dates')
            ->get();

        $grouped = [];

        foreach ($tours as $tour) {
            foreach ($tour->dates as $date) {
                $year = Carbon::parse($date->start_date)->year;
                $month = Carbon::parse($date->start_date)->month;

                $tourCopy = clone $tour;
                $tourCopy->setRelation('nearestDate', $date);

                $grouped[$year][$month][] = $tourCopy;
            }
        }

        ksort($grouped);
        foreach ($grouped as &$months) {
            ksort($months);
            foreach ($months as &$items) {
                usort($items, static function ($a, $b) use ($sortby, $sortdir) {
                    $mul = $sortdir === 'desc' ? -1 : 1;

                    if ($sortby === 'price') {
                        $aVal = $a->nearestDate?->price_usd ?? 0;
                        $bVal = $b->nearestDate?->price_usd ?? 0;
                        return $mul * ($aVal <=> $bVal);
                    }

                    if ($sortby === 'duration') {
                        $aVal = (int) ($a->data['days'] ?? 0);
                        $bVal = (int) ($b->data['days'] ?? 0);
                        return $mul * ($aVal <=> $bVal);
                    }

                    if ($sortby === 'level') {
                        $aVal = (float) ($a->level ?? 0);
                        $bVal = (float) ($b->level ?? 0);
                        return $mul * ($aVal <=> $bVal);
                    }

                    // default: by date
                    $aDate = $a->nearestDate?->start_date;
                    $bDate = $b->nearestDate?->start_date;
                    return $aDate <=> $bDate;
                });
            }
        }

        return $grouped;
    }

}
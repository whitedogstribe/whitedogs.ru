<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;

class BaseController
{
    public array $data = [];

    public function __construct(public \modX $modx)
    {
        $this->data = [
            'countries' => query('countries')
                ->select('id', 'name', 'alias')
                ->get()
                ->toArray()
        ];
    }

    /**
     * Parses sort[by|dir] from request. Supports both ?sortby=&sortdir= and ?sort=price-desc.
     */
    private function parseSortParams(Request $request): array
    {
        $sort = $request->get('sort', '');

        if (!empty($sort)) {
            return explode('-', $sort, 2);
        }

        return [
            $request->get('sortby', 'menuindex'),
            $request->get('sortdir', 'desc'),
        ];
    }

    /**
     * Converts a paginator into the flat data array the templates expect.
     */
    private function extractPaginatorData($paginator, string $itemsKey): array
    {
        return [
            $itemsKey    => $paginator->items(),
            'links'      => $paginator->links()->render(),
            'total'      => $paginator->total(),
            'last_page'  => $paginator->lastPage(),
        ];
    }

    public function getReviews($limit = 100)
    {
        return query('pb_table_data')
            ->where([
                'constructor_id' => 23,
                'field_id' => 276,
            ])
            ->select('id','data')
            ->orderBy('menuindex')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                return json_decode($item->data, 1);
            })
            ->toArray();
    }

    public function ruDate($string, $format = 'j F Y, H:i')
    {
        if (empty($string)) {
            $string = time();
        }

        $timestamp = is_numeric($string) ? $string : strtotime($string);
        $date = date($format, $timestamp);

        $replaces = [
            'January' => 'января',   'February' => 'февраля',
            'March' => 'марта',     'April' => 'апреля',
            'May' => 'мая',         'June' => 'июня',
            'July' => 'июля',       'August' => 'августа',
            'September' => 'сентября','October' => 'октября',
            'November' => 'ноября', 'December' => 'декабря',

            'Monday' => 'Понедельник', 'Tuesday' => 'Вторник',
            'Wednesday' => 'Среда',    'Thursday' => 'Четверг',
            'Friday' => 'Пятница',     'Saturday' => 'Суббота',
            'Sunday' => 'Воскресенье',
        ];

        return strtr($date, $replaces);
    }

    public function dateRange($startDate, $endDate, $locale = 'ru') {
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
            'January' => 'января',   'February' => 'февраля',
            'March' => 'марта',     'April' => 'апреля',
            'May' => 'мая',         'June' => 'июня',
            'July' => 'июля',       'August' => 'августа',
            'September' => 'сентября','October' => 'октября',
            'November' => 'ноября', 'December' => 'декабря',
        ];

        if ($locale === 'ru') {
            $startMonth = $months[$startMonth];
            $endMonth = $months[$endMonth];
        }

        // Один месяц
        if (date('Y-m', $start) === date('Y-m', $end)) {
            return ltrim($startDay, '0') . '-' . ltrim($endDay, '0') . ' ' . $startMonth . ' ' . $startYear;
        }

        // Разные месяцы, один год
        if ($startYear === $endYear) {
            return ltrim($startDay, '0') . ' ' . $startMonth . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $startYear;
        }

        // Разные годы
        return ltrim($startDay, '0') . ' ' . $startMonth . ' ' . $startYear . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $endYear;
    }
}
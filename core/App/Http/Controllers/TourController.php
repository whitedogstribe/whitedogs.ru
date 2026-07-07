<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\PbTableData;
use PageBlocks\App\Models\Resource;
use PageBlocks\App\Models\Tour;
use PageBlocks\App\Models\TourDate;

class TourController extends BaseController
{
    public string $model = Tour::class;
    public string $table = 'tours';
    public string $template = 'tour-page';

    public function show(Request $request, string $alias = '')
    {
        $this->modx->resource = Tour::where('alias', $alias)->first();
        if (!$this->modx->resource) {
            abort(404, 'Тур не найден!');
        }

        $this->modx->resource->parent = 2;
        $this->modx->resource->link_attributes = 'header-white';
        $this->modx->resource->uri = 'tours/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->title;
        $this->modx->resource->template_name = $this->template;
        foreach ($this->modx->resource->data as $name => $value) {
            $this->modx->resource->{$name} = $value;
        }

        $this->data['tour'] = $this->modx->resource;
        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view("file:templates/{$this->template}", $this->data);
    }

    public function day(Request $request, $alias = '', $day = '')
    {
        $tour = Tour::where('alias', $alias)->first();
        if (!$tour) {
            abort(404, 'Тур не найден!');
        }
        $this->template = 'tourday';

        $data = $tour->data;
        foreach ($data as $name => $value) {
            $tour->{$name} = $value;
        }

        $this->modx->resource = PbTableData::where([
            'model_type' => 'PageBlocks\App\Models\Tour',
            'model_id' => $tour->id,
            'data->alias' => $day,
        ])
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->first();

        if (!$this->modx->resource) {
            abort(404, 'День не найден!');
        }

        $this->modx->resource->tour = $tour;
        $this->modx->resource->tour->uri = 'tours/' . $tour->alias;
        $data = $this->modx->resource->data;
        foreach ($data as $key => $value) {
            $this->modx->resource->{$key} = $value;
        }
        $this->modx->resource->template_name = $this->template;

        return view("file:templates/{$this->template}");
    }

    public function oldInsurance(Request $request, $alias)
    {
        $tour = Tour::where('alias', $alias)->first();
        if ($tour) {
            return redirect()->route('tour.insurance', ['alias' => $alias]);
        }

        abort();
    }

    public function insurance(Request $request, $alias)
    {
        $tour = Tour::where('alias', $alias)->first();
        if (!$tour) {
            abort(404, 'Тур не найден!');
        }

        $this->modx->resource = $tour;
        $data = $this->modx->resource->data;
        foreach ($data as $key => $value) {
            $this->modx->resource->{$key} = $value;
        }
        $this->modx->resource->parent = 2;
        $this->modx->resource->link_attributes = 'header-white';
        $this->modx->resource->pagetitle = $tour->title;
        $this->modx->resource->seo_title = "Туристическая страховка в {$tour->country_name} для — {$tour->menutitle}";
        $this->modx->resource->seo_desc = "Здесь можно оформить страховку в {$tour->country_name} и купить билет в $tour->incurance_title для {$tour->title}";
        $this->modx->resource->template_name = 'tour-page';
        $this->modx->resource->uri = 'tours/' . $this->modx->resource->alias;
        $this->modx->resource->alias = 'go';

        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view('file:templates/insurance', $this->data);
    }

    public function dates(Request $request, int $id)
    {
        $dates = TourDate::where('model_id', $id)
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('start_date')
            ->get();

        if (!$dates) {
            return '<option value="">Нет доступных дат</option>';
        }

        $html = '';
        foreach ($dates as $date) {
            $startDate = \Carbon\Carbon::parse($date->start_date)
                ->locale('ru')
                ->translatedFormat('j F Y');

            $endDate = \Carbon\Carbon::parse($date->end_date)
                ->locale('ru')
                ->translatedFormat('j F Y');

            $dateRange = "$startDate - $endDate";
            $price = $date->price > 0
                ? number_format($date->price, 0, '', ' ') . $date->currency
                : number_format($date->price_usd, 0, '', ' ') . '$';
            $status = $date->status === 'closed' ? ' SOLD OUT' : '';

            $html .= sprintf(
                '<option value="%s">%s (%s)%s</option>',
                htmlspecialchars($dateRange),
                htmlspecialchars($dateRange),
                htmlspecialchars($price),
                $status
            );
        }

        return $html;
    }

    public function dayRedirect($alias, $id)
    {
        $tour = Tour::where('alias', $alias)->first();
        if (!$tour) {
            abort(404, 'Тур не найден!');
        }

        return redirect()->route('tour.date', [
            'alias' => $alias,
            'day' => "day-$id"
        ]);
    }

}
<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\Country;
use PageBlocks\App\Models\Resource;
use PageBlocks\App\Models\Tour;
use PageBlocks\App\Models\TourType;

class TourTypeController extends BaseController
{
    public string $model = TourType::class;
    public string $table = 'tour_type';

    public function show(Request $request, string $alias)
    {
        $this->modx->resource = TourType::where('alias', $alias)->firstOrFail();
        if (!$this->modx->resource) {
            abort(404, 'Упс! Мы не нашли страницу!');
        }

        $this->modx->resource->uri = 'tourtype/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->title ?: $this->modx->resource->name;
        $this->modx->resource->parent = 1;
        $this->modx->resource->template_name = 'tourtype';
        $this->modx->resource->reviews = $this->getReviews(3);

        $this->data['tours'] = Tour::with(['dates', 'image'])
            ->withTypeTour($alias)
            ->published()
            ->orderByDate()
            ->get();

        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view('file:templates/tourtype-page', $this->data);
    }

}
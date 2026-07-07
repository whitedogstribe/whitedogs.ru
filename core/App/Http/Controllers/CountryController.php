<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\Country;
use PageBlocks\App\Models\Resource;
use PageBlocks\App\Models\Tour;

class CountryController extends BaseController
{
    public string $model = Country::class;
    public string $table = 'countries';

    public function show(Request $request, string $alias)
    {
        $this->modx->resource = Country::where('alias', $alias)->firstOrFail();
        if (!$this->modx->resource) {
            abort(404, 'Упс! Мы не нашли страну!');
        }

        $this->modx->resource->uri = 'countries/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->title ?: $this->modx->resource->name;
        $this->modx->resource->parent = 1;
        $this->modx->resource->template_name = 'country';
        $this->modx->resource->reviews = $this->getReviews(3);

        $this->data['tours'] = Tour::with(['dates', 'image'])
            ->where('country_id', $this->modx->resource->id)
            ->orWhereJsonContains('countries', $this->modx->resource->alias)
            ->published()
            ->orderByDate()
            ->get();

        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view('file:templates/country-page', $this->data);
    }

}
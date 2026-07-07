<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\Resource;
use PageBlocks\App\Models\Team;
use PageBlocks\App\Models\Tour;

class TeamController extends BaseController
{
    public string $model = Team::class;
    public string $table = 'team';

    public function show(Request $request, string $alias = '')
    {
        $this->modx->resource = Team::where('alias', $alias)->firstOrFail();
        if (!$this->modx->resource) {
            abort(404, 'Упс! Мы не нашли страницу!');
        }

        $this->modx->resource->parent = 4;
        $this->modx->resource->uri = 'team/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->name;
        $this->modx->resource->link_attributes = 'header-white';

        $this->modx->resource->tours = Tour::with('dates', 'image', 'nearestDate')
            ->byAuthor($this->modx->resource->id)
            ->published()
            ->orderByDate()
            ->get();

        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view('file:templates/team-page', $this->data);
    }

}
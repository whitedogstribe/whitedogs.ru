<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\BlogPost;
use PageBlocks\App\Models\Resource;


class BlogController extends BaseController
{
    public string $model = BlogPost::class;
    public string $table = 'blog_posts';

    public function show(Request $request, string $alias = '')
    {
        $this->modx->resource = BlogPost::where('alias', $alias)->first();
        if (!$this->modx->resource) {
            abort(404, 'Упс! Мы не нашли статью!');
        }

        $this->modx->resource->parent = 5;
        $this->modx->resource->uri = 'blog/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->title;

        $this->modx->resource->recordView();

        $this->data['menu'] = Resource::getMenu(0,0, $this->modx->resource->parent);

        return view('file:templates/blog-page', $this->data);
    }

}
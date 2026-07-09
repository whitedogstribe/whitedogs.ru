<?php

namespace PageBlocks\App\Http\Controllers;

use PageBlocks\App\Models\BlogPost;
use PageBlocks\App\Models\PbTableData;
use PageBlocks\App\Models\Team;
use PageBlocks\App\Models\Tour;
use PageBlocks\App\Services\ResourceResolver;
use PageBlocks\App\Models\Resource;
use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Traits\HandlesPagedJsonResponse;
use PageBlocks\App\Traits\HandlesProductListing;

class ResourceController extends BaseController
{
    use HandlesPagedJsonResponse;
    use HandlesProductListing;

    public string $model   = Resource::class;
    public string $table   = 'site_content';
    public string $uri     = '';
    public string $alias   = '';

    public function __construct(\modX $modx)
    {
        $this->uri   = uri();
        $this->alias = alias();
        $modx->resource = (new ResourceResolver())->resolve($this->uri, $this->alias);
        if ($modx->resource) {
            $modx->resource->seo_img = $modx->resource->tv('seo_img', '');
        }

        parent::__construct($modx);
    }

    // -------------------------------------------------------------------------
    //  Entry point
    // -------------------------------------------------------------------------

    public function index(Request $request, string $alias = '')
    {
        if (!$this->modx->resource) {
            return $this->handleMissingResource($alias);
        }

        $this->data['menu'] = Resource::getMenu(0, 0, $this->modx->resource->id);

        if (!$this->modx->resource->template) {
            return $this->renderTemplate('empty');
        }

        return match ($alias) {
            'shop'     => $this->handleShop($request),
            'blog'     => $this->handleBlog($request),
            'tours'    => $this->handleTours($request),
            'calendar' => $this->handleCalendar($request),
            'reviews'  => $this->handleReviews($request),
            'team'     => $this->handleTeam(),
            'about'    => $this->renderTemplate('about'),
            default    => $this->renderTemplate('base'),
        };
    }

    public function context(string $context, string $alias = '')
    {
        if (!$this->modx->resource) {
            abort(404, 'context');
        }

//        $this->modx->resource = updateResource($this->modx->resource, $context);

        $this->modx->config['site_url']      = $this->modx->getOption('site_url') . "$context/";
        $this->modx->config['cultureKey']    = $context;
        $this->modx->context->set('key', $context);

        return view('file:templates/base', [
            'blocks' => $this->model->blocks(),
        ]);
    }

    // -------------------------------------------------------------------------
    //  Page handlers
    // -------------------------------------------------------------------------

    private function handleShop(Request $request)
    {
        $products = $this->getProducts($request);
        $response = $this->formatProductResponse($products, $request);

        if ($request->expectsJson()) {
            return $response;
        }

        $this->data = array_merge($this->data, $response, [
            'categories' => $this->getCategories(),
        ]);

        return $this->renderTemplate('shop');
    }

    private function handleBlog(Request $request)
    {
        $categories = $request->get('categories', '');
        if (is_array($categories)) {
            $categories = implode(',', $categories);
        }

        $posts = BlogPost::with(['team', 'user'])
            ->published()
            ->when($categories, fn($q) => $q->whereIn('category', explode(',', $categories)))
            ->ordered()
            ->paginate(16);

        if ($request->expectsJson()) {
            return $this->pagedJsonResponse(
                view: "file:chunks/blogs/items",
                viewData: ['posts' => $posts->items()],
                paginator: $posts,
            );
        }

        return $this->renderTemplate('blog', $this->extractPaginatorData($posts, 'posts'));
    }

    private function handleTours(Request $request)
    {
        $query = $this->buildToursQuery($request);
        $tours = $query->paginate(18);

        if ($request->expectsJson()) {
            return $this->pagedJsonResponse(
                view: "file:chunks/tours/items",
                viewData: ['tours' => $tours->items()],
                paginator: $tours,
            );
        }

        return $this->renderTemplate('tour', $this->extractPaginatorData($tours, 'tours'));
    }

    private function handleCalendar(Request $request)
    {
        [$sortby, $sortdir] = $this->parseSortParams($request);
        $query  = $this->buildToursQuery($request);
        $tours  = Tour::groupedByYearAndMonth($query, $sortby, $sortdir);
        $total  = $query->count();

        if ($request->expectsJson()) {
            return response()->json([
                'success' => true,
                'data'    => view("file:chunks/tours/items", ['tours' => $tours]),
                'total'   => $total,
            ]);
        }

        return $this->renderTemplate('tour', [
            'tours' => $tours,
            'total' => $total,
        ]);
    }

    private function handleReviews(Request $request)
    {
        $reviews = PbTableData::query()
            ->where('constructor_id', 23)
            ->with('tour')
            ->select('id', 'data', 'model_id', 'published_at')
            ->orderBy('published_at', 'desc')
            ->whereNull('deleted_at')
            ->published()
            ->paginate(10)
            ->through(fn($item) => $this->transformReview($item));

        if ($request->expectsJson()) {
            return $this->pagedJsonResponse(
                view: "file:chunks/reviews/items",
                viewData: ['reviews' => $reviews->items()],
                paginator: $reviews,
            );
        }

        return $this->renderTemplate('reviews', $this->extractPaginatorData($reviews, 'reviews'));
    }

    private function handleTeam()
    {
        $this->modx->resource->leaders = Team::with('gallery')
            ->where('group', 'leader')
            ->orderBy('menuindex')
            ->published()
            ->get()
            ->toArray();

        $this->modx->resource->instructors = Team::where('group', 'instructor')
            ->orderBy('menuindex')
            ->published()
            ->get()
            ->toArray();

        return $this->renderTemplate('base');
    }

    // -------------------------------------------------------------------------
    //  Shared helpers
    // -------------------------------------------------------------------------

    /**
     * Builds the base tours query from request filters + sorting.
     */
    private function buildToursQuery(Request $request)
    {
        [$sortby, $sortdir] = $this->parseSortParams($request);

        return Tour::with(['dates', 'image', 'images', 'nearestDate', 'authors'])
            ->when($request->get('country'),   fn($q, $v) => $q->byCountry($v))
            ->when($request->get('type_tour'), fn($q, $v) => $q->byType($v))
            ->when($request->get('author'),    fn($q, $v) => $q->byAuthor($v))
            ->when($request->get('level'),     fn($q, $v) => $q->where('level', $v))
            ->when($request->get('day_min') || $request->get('day_max'), fn($q) => $q->byDays($request->get('day_min') ?: null, $request->get('day_max') ?: null))
            ->when($request->get('price_min') || $request->get('price_max'), fn($q) => $q->byPrice($request->get('price_min') ?: null, $request->get('price_max') ?: null))
            ->when($sortby, fn($q) => $this->applySorting($q, $sortby, $sortdir))
            ->published()
            ->hasDates();
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

    private function applySorting($query, string $sortby, string $sortdir)
    {
        return match ($sortby) {
            'price'    => $query->orderByPrice($sortdir),
            'duration' => $query->orderByDuration($sortdir),
            'level'    => $query->orderBy('level', $sortdir),
            default    => $query->orderByDate(),
        };
    }

    private function transformReview($item): array
    {
        return array_merge($item->data, [
            'tour_name' => $item->tour->title,
            'tour_url'  => route('tour.show', ['alias' => $item->tour->alias]),
        ]);
    }

    /**
     * Renders a template, optionally merging extra data.
     */
    private function renderTemplate(string $template, array $extra = [])
    {
        $this->modx->resource->template_name = $template;
        $this->data = array_merge($this->data, $extra);

        return view("file:templates/$template", $this->data);
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

    private function handleMissingResource(string $alias)
    {
        $tour = Tour::where('alias', $alias)->first();
        if ($tour) {
            return redirect()->route('tour.show', ['alias' => $tour->alias]);
        }

        $blog = BlogPost::where('alias', $alias)->first();

        if ($blog) {
            return redirect()->route('blog.show', ['alias' => $blog->alias]);
        }

        abort(404);
    }
}
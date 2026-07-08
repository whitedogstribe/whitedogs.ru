<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\Product;
use PageBlocks\App\Models\Resource;
use PageBlocks\App\Traits\HandlesProductListing;


class ProductController extends BaseController
{
    use HandlesProductListing;
    public string $model = Product::class;
    public string $table = 'products';

    public function show(Request $request, string $alias = '')
    {
        $this->modx->resource = Product::with(['gallery'])
            ->where('alias', $alias)
            ->first();
        if (!$this->modx->resource) {

            $category = query('shop_categories')->where('alias', $alias)->first();
            if ($category) {
                return redirect("/shop/categories/$alias");
            }

            abort(404, 'Упс! Мы не нашли товар!');
        }

        $this->modx->resource->uri = 'shop/' . $this->modx->resource->alias;
        $this->modx->resource->pagetitle = $this->modx->resource->title;
        $this->modx->resource->parent = 7;

        $categories = query('shop_categories')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex')
            ->get()
            ->toArray();

        return view('file:templates/shop-page', [
            'menu' => Resource::getMenu(0,0, $this->modx->resource->parent),
            'categories' => $categories,
        ]);
    }

    public function category(Request $request, string $category)
    {
        $this->modx->resource = Resource::where('alias', 'shop')->first();
        $this->modx->resource->alias = $category;
        $this->modx->resource->uri = 'shop/categories/' . $category;
        $this->modx->resource->template = 'shop';
        $this->modx->resource->parent = 7;

        $products = $this->getProducts($request, $category);
        $response = $this->formatProductResponse($products, $request);

        if ($request->expectsJson()) {
            return $response;
        }

        $data = array_merge(
            ['menu' => Resource::getMenu(0, 0, 7)],
            $response,
            ['categories' => $this->getCategories()]
        );

        return view("file:templates/shop", $data);
    }

    public function product(Request $request, int $id)
    {
        $product = Product::with('image')->where([
            'id' => $id,
        ])
            ->select('id', 'title', 'price', 'deposit', 'old_price', 'seo_img', 'rent', 'rental_prices')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->first();

        if (!$product) {
            return response()->error('Product not found');
        }

        $productData = $product->toArray();
        $seoImg = json_decode($productData['seo_img'], true);
        $imageUrl = $seoImg['url'] ?? $product->image?->url ?? null;
        $productData['img'] = $imageUrl ? '/' . $imageUrl : null;
        $productData['thumb'] = $imageUrl
            ? \Boshnik\PageBlocks\Facades\Glide::url($imageUrl, 'w=60&h=60&fit=contain&fm=webp')
            : null;
        $productData['deposit'] = (float)($productData['old_price'] ?: $productData['deposit']);
        unset($productData['seo_img'], $productData['old_price']);

        return response()->json([
            'success' => true,
            'id' => $id,
            'product' => $productData,
        ]);
    }

}
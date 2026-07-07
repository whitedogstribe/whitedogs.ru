<?php

namespace PageBlocks\App\Traits;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\Product;

trait HandlesProductListing
{
    protected function getProducts(Request $request, ?string $category = null)
    {
        $sortby = $request->get('sortby', 'menuindex');
        $sortdir = $request->get('sortdir', 'desc');

        $query = Product::with('image')->published()->orderBy($sortby, $sortdir);

        if ($category) {
            $query->byCategory($category);
        }

        return $query->paginate(40);
    }

    protected function formatProductResponse($products, Request $request)
    {
        if ($request->expectsJson()) {
            $type = $request->get('type', '');
            return response()->json([
                'success' => true,
                'data' => view("file:chunks/shop/items", ['products' => $products->items(), 'type' => $type]),
                'links' => $products->links()->render(),
                'total' => $products->total(),
                'current_page' => $products->currentPage(),
                'last_page' => $products->lastPage(),
            ]);
        }

        return [
            'products' => $products->items(),
            'links' => $products->links()->render(),
            'total' => $products->total(),
            'totalPage' => $products->lastPage(),
        ];
    }

    protected function getCategories(): array
    {
        return query('shop_categories')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex', 'asc')
            ->get()
            ->toArray();
    }
}
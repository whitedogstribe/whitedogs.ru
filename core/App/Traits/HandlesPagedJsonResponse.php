<?php

namespace PageBlocks\App\Traits;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

/**
 * Eliminates the repeated if ($request->expectsJson()) { ... } boilerplate
 * found in every paginated page handler.
 */
trait HandlesPagedJsonResponse
{

    protected function pagedJsonResponse(
        string $view,
        array $viewData,
        $paginator,
        array $extra = []
    ) {
        return response()->json(array_merge([
            'success'      => true,
            'data'         => view($view, $viewData),
            'links'        => $paginator->links()->render(),
            'total'        => $paginator->total(),
            'current_page' => $paginator->currentPage(),
            'last_page'    => $paginator->lastPage(),
        ], $extra));
    }
}
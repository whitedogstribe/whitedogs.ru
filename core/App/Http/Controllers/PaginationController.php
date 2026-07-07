<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use Boshnik\PageBlocks\Services\pbSnippet;

class PaginationController extends BaseController
{
    public function items(Request $request): array
    {
        $request->validate([
            'page' => 'required|integer|min:1',
            'sortby' => 'required|string',
            'sortdir' => 'required|string',
            'total' => 'required|integer',
            'key' => 'required|string',
        ]);

        $properties = $_SESSION['pageblocks'][$request->key] ?? [];
        $properties['page'] = $request->page;
        $properties['sortby'] = $request->sortby;
        $properties['sortdir'] = $request->sortdir;
        $properties['total'] = $request->total;
        $properties['toPlaceholder'] = '';
        $filterFields = explode(',', $properties['filterFields']);
        $properties['filters'] = array_intersect_key($request->all(), array_flip($filterFields));

        $snippet = new pbSnippet($this->modx, $properties);
        $items = $snippet->getItems();

        return [
            'success' => true,
            'data' => $snippet->response($items),
            'links' => $snippet->getPagination(),
            'total' => $snippet->getTotal(),
        ];
    }
}
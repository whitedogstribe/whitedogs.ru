<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\GearItem;

class GearController extends BaseController
{
    public function item(Request $request, int $id)
    {
        $item = GearItem::find($id);
        if (!$item) {
            return response()->json(['success' => false], 404);
        }

        return response()->json([
            'success' => true,
            'data' => [
                'id'          => $item->id,
                'name'        => $item->name,
                'img'         => $item->data['img'] ?? '',
                'description' => $item->data['description'] ?? '',
                'where_buy'   => $item->data['where_buy'] ?? '',
                'brand'       => $item->data['brand'] ?? '',
            ],
        ]);
    }

    public function all(Request $request)
    {
        $items = GearItem::orderBy('menuindex')->get()->map(fn($i) => [
            'id'   => $i->id,
            'name' => $i->name,
        ]);

        return response()->json(['success' => true, 'data' => $items]);
    }
}

<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Controllers\DataController;
use PageBlocks\App\Models\PbBlockData;
use Boshnik\PageBlocks\Http\Request;

class BlockDataController extends DataController
{
    public string $table = 'pb_block_data';
    public string $model = PbBlockData::class;
    public string $constructorType = 'pbBlock';

    public function copyByID($id, Request $request)
    {
        $validated = $request->validate([
            'model_type' => 'required',
            'model_id' => 'required',
            'context_key' => 'required',
        ]);
        $original = $this->model::find($id);
        if (!$original) {
            return response()->append([
                'total' => 0,
                'data' => [],
            ])->error("Error: Record not found");
        }

        if (!$original->copy($validated)) {
            return response()->append([
                'total' => 0,
                'data' => [],
            ])->error("Error copying $original->id");
        }

        return response()->append([
            'total' => 1,
            'data' => [],
        ])->success("Success: Copied $original->id");
    }

    public function createSync(Request $request)
    {

    }

    protected function afterPrepareArray(array $array = [], $constructor_id = null): array
    {
        if ($array['readyblock_id']) {
            $array['actions'][] = [
                'cls' => '',
                'icon' => 'icon icon-refresh action-red',
                'title' => $this->modx->lexicon('pb_block_remove_sync'),
                'action' => 'removeSync',
                'button' => false,
                'menu' => true,
            ];

//            $array['actions'][] = [
//                'cls' => '',
//                'icon' => 'icon icon-retweet',
//                'title' => $this->modx->lexicon('pb_sync_fields'),
//                'action' => 'syncFieldObject',
//                'button' => false,
//                'menu' => true,
//            ];
        } else {
            $array['actions'][] = [
                'cls' => '',
                'icon' => 'icon icon-refresh action-green',
                'title' => $this->modx->lexicon('pb_block_create_sync'),
                'action' => 'createSync',
                'button' => false,
                'menu' => true,
            ];
        }

        return $array;
    }
}
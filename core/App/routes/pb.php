<?php

use Boshnik\PageBlocks\Facades\Route;
use PageBlocks\App\Http\Controllers\TableDataController;

Route::prefix('/pageblocks/pagination')->group(function() {
    Route::get('/items', 'PaginationController@items');
});

Route::post('mgr/pb/data/tables/clear', [TableDataController::class, 'clearAll'])->middleware('modauth');
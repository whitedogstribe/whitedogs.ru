<?php

use Boshnik\PageBlocks\Facades\Route;

Route::prefix('/pageblocks/pagination')->group(function() {
    Route::get('/items', 'PaginationController@items');
});
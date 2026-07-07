<?php

use Boshnik\PageBlocks\Facades\Route;

Route::prefix('api')->group(function () {
    Route::get('/products/{id}', 'ProductController@product');
    Route::get('/tour/{id}/dates', 'TourController@dates');
    Route::get('/search', 'SearchController@search');
    Route::get('/gear/{id}', 'GearController@item');
    Route::get('/gear', 'GearController@all');
});
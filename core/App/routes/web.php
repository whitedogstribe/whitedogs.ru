<?php

use Boshnik\PageBlocks\Facades\Route;

// Redirect
Route::redirect('/index', '/');
Route::redirect('/route', '/tours');
Route::redirect('/shop/categories', '/shop');

Route::redirect('/route/rossiya', '/countries/russia');
Route::redirect('/route/turtsiya', '/countries/turkey');
Route::redirect('/route/argentina', '/countries/argentina');
Route::redirect('/route/gruziya', '/countries/georgia');
Route::redirect('/route/kirgizstan', '/countries/kyrgyzstan');
Route::redirect('/route/nepal', '/countries/nepal');
Route::redirect('/route/portugaliya', '/countries/portugal');
Route::redirect('/route/tadzhikistan', '/countries/tajikistan');
Route::redirect('/route/tailand', '/countries/thailand');
Route::redirect('/route/tanzaniya', '/countries/tanzania');

Route::redirect('/route/mountain-trekking', '/tourtype/mountainTrekking');
Route::redirect('/route/mountaineering', '/tourtype/mountaineering');
Route::redirect('/route/motorcycle', '/tourtype/motorcycle');
Route::redirect('/route/yachting', '/tourtype/yachting');
Route::redirect('/route/water-attractions', '/tourtype/waterAttractions');
Route::redirect('/tours/puteshestvie-na-sokotru', '/tours/sokotra');

Route::redirect('/countries', '/');
Route::redirect('/tourtypes', '/');
Route::get('/{alias}/go', 'TourController@oldInsurance');
Route::get('/{alias}/day-{id}', 'TourController@dayRedirect');

Route::post('/form/{alias}', 'FormController@submit');
Route::post('/tours/filter', 'TourController@filter')->name('tour.filter');
Route::get('/tours/{alias}', 'TourController@show')->name('tour.show');
Route::get('/tours/{alias}/go', 'TourController@insurance')->name('tour.insurance');
Route::get('/tours/{alias}/{day}', 'TourController@day')->name('tour.date');
Route::get('/team/{alias}', 'TeamController@show')->name('team.show');

Route::get('/blog/{alias}', 'BlogController@show')->name('blog.show');
Route::get('/shop/categories/{category}', 'ProductController@category');
Route::get('/shop/{alias}', 'ProductController@show');

// Sitemap
Route::get('/sitemap.xml', 'SitemapController@index');
Route::get('/sitemap/{alias}.xml', 'SitemapController@show');

// Pages
Route::get('/{alias?}', 'ResourceController@index');
//Route::get('/{context}/{alias?}', 'ResourceController@context')->where('context', '[a-z]{2}');


// Countries
Route::get('/countries/{alias}', 'CountryController@show')->name('country.show');
Route::get('/tourtype/{alias}', 'TourTypeController@show')->name('tourtype.show');

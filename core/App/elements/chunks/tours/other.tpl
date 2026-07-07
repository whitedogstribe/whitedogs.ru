{set $tours = model('Tour')
    ->with(['image', 'images', 'dates'])
    ->where('tours.id', '!=', $modx->resource->id)
    ->published()
    ->open()
    ->orderOpenByDate()
    ->limit(4)
    ->get()}

{insert 'file:chunks/tours/card2-assets.tpl'}

<section class="other-travels pt-4 pb-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">Другие путешествия</h2>
                <p class="header-description desc-short mx-auto">Решили, что этот маршрут не для вас? Не беда - у нас есть ещё куча направлений - выбирай по душе:</p>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 gy-5">
            {foreach $tours as $tour}
                {include 'file:chunks/tours/card2.tpl'}
            {/foreach}
        </div>
        <div class="row">
            <div class="col-auto mx-auto text-center mt-5">
                <a href="{urlName('tours')}" class="d-inline-flex btn btn-danger text-uppercase px-5 py-3 rounded-5">Все направления</a>
            </div>
        </div>
    </div>
</section>

{if $modx->resource->tour_id}
    {set $tour = model('Tour')
    ->with(['image', 'images', 'dates', 'authors'])
    ->published()
    ->open()
    ->where('tours.id', $modx->resource->tour_id)
    ->first()}
{/if}

{if !$tour}
    {set $tour = model('Tour')
    ->with(['image', 'images', 'dates', 'authors'])
    ->published()
    ->open()
    ->orderOpenByDate()
    ->first()}
{/if}

{if $tour}
{insert 'file:chunks/tours/card2-assets.tpl'}
<div>
    <h5 class="mb-3">Рекомендуем:</h5>
    <div class="row">
        {include 'file:chunks/tours/card2.tpl'}
    </div>
</div>
{/if}

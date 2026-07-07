{set $tours = model('Tour')->with(['dates', 'image', 'nearestDate'])->hasDates()->orderOpenByDate()->published()->limit(2)->get()->toArray()}
<div class="other-travels pt-4 pb-5">
    <div class="row">
        <div class="col-12 mb-5">
            <h4 class="font-cofo text-uppercase">Ближайшие путешествия</h4>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-3 gy-5 mb-5">
        {foreach $tours as $tour}
            {include 'file:chunks/tours/card.tpl'}
        {/foreach}
    </div>
    <div class="row">
        <div class="col-12 text-center">
            <a href="{urlName('tours')}" class="d-inline-flex btn btn-danger text-uppercase px-5 py-3 rounded-5">Все направления</a>
        </div>
    </div>
</div>
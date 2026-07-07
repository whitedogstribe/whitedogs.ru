{extends 'file:templates/base.tpl'}

{block 'seo'}
    <title>Страховка и билеты: {$modx->resource->menutitle ?: $modx->resource->pagetitle} — {if $modx->resource->city_name}{$modx->resource->city_name}, {/if}{$modx->resource->country_name}  / {'site_name'|config}</title>
    <meta name="description" content="Страховка и авиабилеты для тура «{$modx->resource->menutitle ?: $modx->resource->pagetitle}» — {if $modx->resource->city_name}{$modx->resource->city_name}, {/if}{$modx->resource->country_name}. Онлайн-оформление.">
{/block}

{block 'schema'}
    {insert 'file:chunks/seo/insurance.tpl'}
{/block}

{block 'beforeBlocks'}
    {insert 'file:chunks/svg.tpl'}
{/block}

{block 'beforeBlocks'}
    {insert 'file:chunks/svg.tpl'}
{/block}

{block 'blocks'}
    {set $img = $modx->resource->images[0]}
    {set $video = $modx->resource->video|fromJSON}
    {set $country = $modx->resource->country|fromJSON}
    {set $city = $modx->resource->city|fromJSON}
    {if $modx->resource->cherehapa_sports}
        {set $cherehapa_sports = '["' ~ ($modx->resource->cherehapa_sports|join:'","') ~ '"]'}
    {else}
        {set $cherehapa_sports = ''}
    {/if}
    {set $dates = $modx->resource->dates[0]}

    {insert 'file:chunks/blocks/insurance-hero.tpl'}
    {insert 'file:chunks/blocks/insurance-team.tpl'}
    <section id="cherehapa">
        <script
                async
                data-che-options='{ "marker":"{$modx->resource->alias}","partnerId":"10990","countries":["{$country.alias}"], "sports":{$cherehapa_sports}, "dateStart":"{$dates->start_date|date:'j.m.Y'}","dateEnd":"{$dates->end_date|date:'j.m.Y'}", "isFrame":"true","isLogo":"false", "tourists":["34"], "isCheSupport":false}'
                data-che-colors='{ "primary":"#22c29e" }'
                src="https://static.cherehapa.ru/widgets/loader.min.js"></script>
    </section>

    {insert 'file:chunks/blocks/insurance-faq.tpl'}

    <section id="aviasales" class="py-4">
        <div class="container mx-auto">
            <div class="text-center">
                <h6>Авиабилеты</h6>
                <h2 class="font-cofo">Билеты в {$city.name}, {$country.name}</h2>
                <p class="mb-10 max-w-3xl mx-auto">
                    Поиск дешёвых авиабилетов в {$city.name}, {$country.name} с помощью Aviasales
                </p>
            </div>
            <script
                    async
                    src="//tp.media/content?currency=rub&promo_id=7879&shmarker=354528.whitedogs&campaign_id=100&trs=191027&combine_promos=&show_hotels=false&border_radius=9&plain=true&primary=%23FF8E01&secondary=%23FFFFFF&dark=%23262626&light=%23FFFFFF&special=%23C4C4C4&no_labels=true&locale=ru&powered_by=true&destination={$modx->resource->punkt_aviasales}"
                    charset="utf-8"></script>
        </div>
    </section>
{/block}
{block 'content'}{/block}
{extends 'file:templates/base.tpl'}

{block 'schema'}
    {insert 'file:chunks/seo/tourtype.tpl'}
{/block}

{block 'content'}
    <section class="section-country pt-5 mt-5">
        <div class="container">
            <h1 class="font-cofo">{$modx->resource->pagetitle}</h1>
            {if $modx->resource->subtitle}
                <h4>{$modx->resource->subtitle}</h4>
            {/if}

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-3 my-3">
                {foreach $tours as $tour}
                    {insert 'file:chunks/tours/card.tpl'}
                {/foreach}
            </div>

            {if $modx->resource->content}
                <div class="my-5">
                    {$modx->resource->content}
                </div>
            {/if}

            <h2 class="font-cofo mb-3">Смотрите так же:</h2>
            <ul class="list-unstyled d-flex flex-wrap gap-3 mb-5">
                {foreach tourTypes() as $item}
                    <li class="nav-item{if $item->id == $modx->resource->id && $modx->resource->template_name == 'tourtype'} d-none{/if}">
                        <a class="h5" href="/tourtype/{$item->alias}">{$item->name}</a>
                    </li>
                {/foreach}
            </ul>

            <h2 class="font-cofo mb-3">Туры по странам:</h2>
            <ul class="list-unstyled d-flex flex-wrap gap-3 mb-5">
                {foreach $countries as $item}
                    <li class="nav-item{if $item->id == $modx->resource->id && $modx->resource->template_name == 'country'} d-none{/if}">
                        <a class="h5" href="/countries/{$item->alias}">{$item->name}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
    {insert 'file:chunks/blocks/reviews'}
    {foreach blocks(['id' => 757]) as $block}
        {$block->render()}
    {/foreach}
    {insert 'file:chunks/blocks/order'}
{/block}
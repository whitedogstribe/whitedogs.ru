{block 'placeholders'}
    {set $tour = $modx->resource}
    {set $modx->resource->start_date = $modx->resource->dates[0]['start_date']|date:'Y-m-d'}
    {if $.get.start_date}
        {foreach $tour->dates as $date}
            {if $.get.start_date == $date->start_date|date:'Y-m-d'}
                {set $modx->resource->price = $date->price_format}
                {set $modx->resource->clear_price = $date->clear_price}
                {set $modx->resource->old_price = $date->old_price_format}
                {set $modx->resource->discount = $date->discount}
                {set $modx->resource->start_date = $date->start_date|date:'Y-m-d'}
            {/if}
        {/foreach}
    {/if}
{/block}

{extends 'file:templates/base.tpl'}

{block 'schema'}
    {set $ids = [$modx->resource->id]}
    {if $modx->resource->reviews_default}
        {foreach $modx->resource->reviews_default as $review_id}
            {set $ids[] = $review_id}
        {/foreach}
    {/if}
    {set $reviews = reviews($ids)}
{*    {insert 'file:chunks/seo/tour.tpl'}*}
{/block}

{block 'style'}
    <style>
        body {
            padding-top: 0;
            background: #fff;
        }
        .price {
            font-weight: bold;
            line-height: 1;
            text-align: center;
            background-image: linear-gradient(to right, #20C19C, #5DC1E0, #20C19C);
            background-size: 200%;
            background-clip: text;
            color: transparent;
            -webkit-text-fill-color: transparent;
            -webkit-font-smoothing: antialiased;
        }
        .dot{
            width: 13px;
            height: 13px;
            display: inline-block;
            border-radius:50%;
            border:2px solid #fff;
        }

        .dot.full{
            background:#fff;
            border-color:#fff;
        }

        .dot.half{
            background:linear-gradient(90deg, #fff 50%, transparent 50%);
            border-color:#fff;
        }
        .svg-section-top {
            transform: matrix(-1, 0, 0, -1, 0, 0);
        }
        .dropdown-menu .nav-link {
            color: var(--color-black);
        }
    </style>
    <script>
        const Tour = {
            dates: {$modx->resource->dates},
            price: parseInt('{$modx->resource->clear_price}'),
            currency: '{$modx->resource->currency}',
            start_date: '{$modx->resource->start_date}',
        }
    </script>
{/block}

{block 'beforeBlocks'}
    {insert 'file:chunks/svg.tpl'}
{/block}
{block 'blocks'}
    <div data-bs-spy="scroll" data-bs-target="#navbar-scrollspy" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true">
        {set $blocks = ['hero', 'statistics', 'signup', 'content', 'gallery', 'plan', 'guides', 'gallery-simple', 'pricing', 'food', 'reviews', 'equipment', 'faq', 'cta', 'lastblog', 'other']}
        {foreach $blocks as $block}
            {include ('file:chunks/tours/' ~ $block)}
        {/foreach}

    </div>
    {insert 'file:chunks/layout/tour-mobile-menu.tpl'}
{/block}
{block 'content'}{/block}

{block 'modal'}
    {insert 'file:chunks/modals/tour.tpl'}
{/block}
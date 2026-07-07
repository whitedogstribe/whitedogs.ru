{if $modx->resource->tours|length}
<section class="leads-travels">
    <div class="container">
        <div class="row">
            <h3 class="header-subtitle fw-bold mb-3">Ведет путешествия ({$modx->resource->tours|length})</h3>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-3 mb-5">
            {foreach $modx->resource->tours as $tour}
                {insert 'file:chunks/tours/card.tpl'}
            {/foreach}
        </div>
    </div>
</section>
{/if}
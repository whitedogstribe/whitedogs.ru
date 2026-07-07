{if $modx->resource->alias == 'calendar'}
    {foreach $tours as $year => $months}
        <div class="tours-year pb-5">
            {foreach $months as $month => $items}
                <h2 class="h5 font-cofo text-uppercase">{$.pb.months[$month]} {$year}</h2>
                <hr>
                {foreach $items as $tour}
                    {include ('file:chunks/tours/list.tpl')}
                {/foreach}
            {/foreach}
        </div>
    {/foreach}
{else}
    {foreach $tours as $tour}
        {include ('file:chunks/tours/card2.tpl')}
    {/foreach}
{/if}
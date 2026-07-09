{set $resourceId = $modx->resource ? $modx->resource->id : 0}
{set $rows = query('pb_table_data')->where('constructor_id', 35)->where('field_id', 407)->where('model_id', $resourceId)->where('model_type', 'PageBlocks\\App\\Models\\BlogPost')->whereNull('deleted_at')->orderBy('menuindex', 'asc')->get()}
{if $rows|length}
<div class="row equipment-list">
    {foreach $rows as $row}
        {set $item = $row->data|fromJSON}
        {set $imgRaw = $item.img|fromJSON}
        {set $imgUrl = $imgRaw.url|default:''}
        <div class="col-12">
            <div class="row">
                {if $imgUrl}
                <div class="col-xs-12 col-sm-4">
                    <img loading="lazy" src="{$imgUrl|glide:'fm=webp'}" class="img-fluid" alt="{$item.title}">
                </div>
                {/if}
                <div class="col-xs-12 {if $imgUrl}col-sm-8{/if}">
                    <h5>{$item.title}</h5>
                    {if $item.description}
                        <div class="equipment-description">{$item.description}</div>
                    {/if}
                    {if $item.where || $item.brand}
                        <blockquote>
                            {if $item.where}<strong>Где купить:</strong> {$item.where}{if $item.brand}<br />{/if}{/if}
                            {if $item.brand}<strong>Предпочтительные бренды:</strong> {$item.brand}{/if}
                        </blockquote>
                    {/if}
                </div>
            </div>
        </div>
    {/foreach}
</div>
{/if}

<div class="col-12">
    <div class="row">
        <div class="col-xs-12 col-sm-4">
            <img loading="lazy" src="{$img.url|glide:'w=220&fit=crop&fm=webp'}" alt="{$title|notags}" />
        </div>
        <div class="col-xs-12 col-sm-8">
            <h5>{$title}</h5>
            <p>{$description}</p>
            <blockquote>
                <strong>Где купить:</strong> {$where} <br />
                <strong>Предпочтительные бренды:</strong> {$brand}
            </blockquote>
            {if $products}
                <h4>Это снаряжение можно взять в аренду или купить:</h4>
                <div>{$products|shop}</div>
            {/if}
        </div>
    </div>
</div>

<section class="insurance-team py-4">
    <div class="container" style="max-width: 1092px">

        {foreach $modx->resource->authors as $idx => $author}
            {if !$idx}
                <div class="row align-items-center{if $idx is odd} flex-lg-row-reverse{/if}">
                    <div class="col-12 col-md-auto mb-4">
                        {set $img = $author->avatar|fromJSON}
                        <img loading="lazy" src="{$img.url|glide:'w=380&h=380&fit=crop&fm=webp'}" width="380" height="380" alt="{$author->name}">
                    </div>
                    <div class="col">
                        <h3 class="fw-bold">Совсем скоро состоися <a class="text-success" href="/tours/{$modx->resource->alias}">{$modx->resource->title}</a> , ты готов?</h3>
                        <p>Я <span class="fw-bold">{$author->name}</span>, гид этого похода. Пробовать что-то новое всегда довольно страшно. Но именно новое стимулирует наш мозг создавать нейронные связи, менять картину мира, переосмысливать старое. Делая что-то в первый раз - мы получаем бесценный опыт, развиваемся.</p>
                        <p>Не пренебрегайте туристической страховкой. Никто не застрахован от несчастных случаев и если такой (не дай Бог) случиться, то страховка сэкономит ваши деньги. Эвакуация вертолётом и лечение в чужой стране стоят десятки тысяч долларов. Лучше потратить пару тысяч рублей и быть спокойным, чем нервничать и решать проблемы и тратить огромные деньги в экстренной ситуации самому!</p>
                    </div>
                </div>
            {/if}
        {/foreach}

    </div>
</section>
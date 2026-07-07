<section class="principles-section pt-4 pb-5">
    <div class="container">
        <div class="row justify-content-center">
            {foreach $items as $item}
                <div class="col-12 col-lg-3">
                    <div class="item">
                        {set $img = $item.image|fromJSON}
                        <div class="mb-3 d-flex align-items-center justify-content-center" style="height: 150px">
                            <img loading="lazy" src="{$img.url}" alt="{$img.title ?: $item.title}">
                        </div>
                        <h5 class="fw-bold text-uppercase mb-3 text-center">{$item['title']}</h5>
                        <small>{$item.description}</small>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</section>
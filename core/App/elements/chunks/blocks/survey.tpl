<section class="survey-section pt-4 pb-5">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="h3 fw-bold">{$title}</h1>
                {if $subtitle}
                    <p>{$subtitle}</p>
                {/if}
            </div>
        </div>
        <div class="col-12 col-md-8 mx-auto">
            <div class="row align-items-center">
                {if $img}
                    {set $img = $img|fromJSON}
                    <div class="col-auto">
                        <img loading="lazy" class="img-fluid" src="{$img.url|glide:'w=300&h=300&fit=crop&fm=webp'}" alt="{$title}">
                    </div>
                {/if}
                <div class="col">
                    {$content}
                    {if $btn_text && $btn_link}
                        <a href="{$btn_link}" class="d-inline-flex btn btn-lg btn-outline-danger rounded-5" target="_blank" rel="nofollow">{$btn_text}</a>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</section>
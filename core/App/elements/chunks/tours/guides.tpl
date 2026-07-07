<section class="guides-section pt-4 pb-3 pb-md-5" id="team">
    <div class="container" style="max-width: 900px">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">{$modx->resource->team_title ?: "Кто ведёт поход"}</h2>
                {if $modx->resource->team_subtitle}
                    <h3 class="header-subtitle h5 fw-normal">{$modx->resource->team_subtitle ?: ("В программе " ~ ($modx->resource->menutitle ?: $modx->resource->title) ~ " вас будут сопровождать:")}</h3>
                {/if}
            </div>
        </div>

        {foreach $modx->resource->authors as $idx => $author}
            <div class="row align-items-center{if $idx is odd} flex-lg-row-reverse{/if} mb-5">
                <div class="col-12 col-md-auto mb-4 text-center">
                    {set $img = $author->avatar|fromJSON}
                    <img loading="lazy" src="{$img.url|glide:'w=380&h=380&fit=crop&fm=webp'}" class="img-fluid" width="380" height="380" alt="{$author->name}">
                </div>
                <div class="col text-center text-md-start">
                    <h4 class="h5 mb-0 fw-semibold">
                        <a href="{route('team.show', ['alias' => $author->alias])}">{$author->name}</a>
                    </h4>
                    {if $author->position}
                        <small class="text-muted">{$author->position}</small>
                    {/if}
                    <p class="my-4">{$author->description}</p>
                    <div class="d-flex flex-wrap gap-4 justify-content-center justify-content-md-start">
                        {if $author->instagram}
                            <a href="{$author->instagram}" target="_blank" class="text-decoration-none">
                                <img loading="lazy" src="/assets/images/content/icons/inst.svg" width="24" height="24" alt="{$author->instagram}">
                            </a>
                        {/if}
                        {if $author->vk}
                            <a href="{$author->vk}" target="_blank" class="text-decoration-none">
                                <img loading="lazy" src="/assets/images/content/icons/vk.svg" width="24" height="24" alt="{$author->vk}">
                            </a>
                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}

        <div class="d-flex justify-content-center">
            <button type="button"
                    class="btn btn-danger text-uppercase px-5 py-3 rounded-5"
                    data-bs-toggle="modal"
                    data-bs-target="#modal-signup"
                    data-id="{$modx->resource->id}"
                    data-title="{$modx->resource->title}"
                    data-url="{$modx->config.site_url}{$modx->resource->uri}"
                    data-price="{$modx->resource->price}"
            >
                <span class="px-4 fw-bold">Хочу в поход!</span>
            </button>
        </div>
    </div>
</section>
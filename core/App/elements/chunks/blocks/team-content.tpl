<section class="team-content pt-4 pb-5">
    <div class="container">
        {set $crumbs=[['title'=>'Про нас','url'=>'/about'],['title'=>$modx->resource->title,'url'=>'']]}
        {insert 'file:chunks/breadcrumbs.tpl'}
        <div class="row">
            <div class="col-12 col-lg-7 order-2 order-lg-1">
                {if $modx->resource->position}
                    <h2 class="font-cofo text-center text-lg-start">{$modx->resource->position}</h2>
                {/if}
                <div class="d-flex gap-2 mb-3 justify-content-center justify-content-lg-start">
                    {if $modx->resource->instagram}
                        <a href="{$modx->resource->nstagram}" target="_blank" class="text-decoration-none">
                            {* TODO: временно отключено, ждём иконку из Figma-экспорта *}
                            {* <img loading="lazy" src="/assets/images/content/icons/inst.svg" width="26" height="26" alt="{$modx->resource->instagram}"> *}
                        </a>
                    {/if}
                    {if $modx->resource->vk}
                        <a href="{$modx->resource->vk}" target="_blank" class="text-decoration-none">
                            <img loading="lazy" src="/assets/images/content/icons/vk.svg" width="26" height="26" alt="{$modx->resource->vk}">
                        </a>
                    {/if}
                </div>
                <div class="text-editor">
                    {$modx->resource->content}
                </div>
            </div>
            <div class="col-12 col-lg-5 order-1 order-lg-2 text-center">
                {set $img = $modx->resource->avatar|fromJSON}
                <img loading="lazy" src="{$img.url|glide:'w=409&h=409&fit=crop&fm=webp'}" width="409" height="409" class="img-fluid" alt="{$modx->resource->name}">
            </div>
        </div>
    </div>
</section>
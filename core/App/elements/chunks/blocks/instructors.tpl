<section class="instructors-section mb-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-3">
                <h2 class="fw-bold text-uppercase">{$title}</h2>
            </div>
            <div class="col">
                <div class="row g-3">
                    {foreach $modx->resource->instructors as $item}
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="instructor h-100 bg-white rounded-3 p-3">
                                <h5>
                                    <a href="{route('team.show', ['alias' => $item.alias])}">
                                        {$item.name}
                                    </a>
                                </h5>
                                <div class="d-flex flex-wrap gap-2">
                                    {if $item.instagram}
                                        <a href="{$item.instagram}" target="_blank" class="text-decoration-none">
                                            {* TODO: временно отключено, ждём иконку из Figma-экспорта *}
                                            {* <img loading="lazy" src="/assets/images/content/icons/inst.svg" width="13" height="13" alt="{$item.instagram}"> *}
                                        </a>
                                    {/if}
                                    {*                                            {if $item.facebook}*}
                                    {*                                                <a href="{$item.facebook}" target="_blank" class="text-decoration-none">*}
                                    {*                                                    <i class="bi bi-facebook"></i>*}
                                    {*                                                </a>*}
                                    {*                                            {/if}*}
                                    {if $item.vk}
                                        <a href="{$item.vk}" target="_blank" class="text-decoration-none">
                                            <img loading="lazy" src="/assets/images/content/icons/vk.svg" width="13" height="13" alt="{$item.vk}">
                                        </a>
                                    {/if}
                                </div>
                                {set $img = $item.avatar|fromJSON}
                                <a href="{route('team.show', ['alias' => $item.alias])}" class="d-block text-center mb-3">
                                    <img loading="lazy" src="{$img['url']|glide:'w=273&h=273&fit=crop&fm=webp'}" width="273" height="273" class="img-fluid" alt="{$item.name}">
                                </a>
                                <small>{$item.description}</small>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</section>
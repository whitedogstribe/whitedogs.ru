<section class="leaders-section py-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-3 position-relative">
                <h2 class="fw-bold text-uppercase">{$title}</h2>
                <div class="d-block d-md-none">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
                <ul class="d-none d-lg-flex flex-column list-unstyled" id="navCarousel">
                    {foreach $modx->resource->leaders as $idx => $item}
                        <li class="mb-3 slide-item{if !$idx} active{/if}" data-slide="{$idx}">
                            {$item.name}
                        </li>
                    {/foreach}
                </ul>
            </div>
            <div class="col">
                <div class="f-carousel" id="leaders-carousel">
                    {foreach $modx->resource->leaders as $item}
                    <div class="f-carousel__slide">
                        <div class="row g-4 align-items-center">
                            <div class="col-lg col-12">
                                <div class="bg-white rounded-4 h-100 d-flex flex-column flex-lg-row">
                                    <div class="p-4">
                                        <h3 class="mb-2">
                                            <a href="{route('team.show', ['alias' => $item.alias])}">{$item.name}</a>
                                        </h3>
                                        <p class="text-muted mb-3">{$item.position}</p>
                                        <div class="d-flex gap-2 mb-3">
                                            {if $item.instagram}
                                                <a href="{$item.instagram}" target="_blank" class="text-decoration-none">
                                                    {* TODO: временно отключено, ждём иконку из Figma-экспорта *}
                                                    {* <img loading="lazy" src="/assets/images/content/icons/inst.svg" width="13" height="13" alt="{$item.instagram}"> *}
                                                </a>
                                            {/if}
{*                                            {if $item->facebook}*}
{*                                                <a href="{$item->facebook}" target="_blank" class="text-decoration-none">*}
{*                                                    <i class="bi bi-facebook"></i>*}
{*                                                </a>*}
{*                                            {/if}*}
                                            {if $item.vk}
                                                <a href="{$item.vk}" target="_blank" class="text-decoration-none">
                                                    <img loading="lazy" src="/assets/images/content/icons/vk.svg" width="13" height="13" alt="{$item.vk}">
                                                </a>
                                            {/if}
                                        </div>
                                        <p>{$item.description}</p>
                                    </div>
                                    {set $img = $item.avatar|fromJSON}
                                    <img loading="lazy" src="{$img.url|glide:'w=409&h=409&fit=crop&fm=webp'}" width="409" height="409" class="img-fluid" alt="{$item->name}">
                                </div>
                            </div>
                            {if $item.gallery}
                            <div class="col-lg-auto col-12">
                                {set $name = $item.name|split: ' '}
                                <h5 class="mb-3">{$name[0]} в жизни</h5>

                                <div class="row g-1" style="max-width:244px">
                                   {foreach $item.gallery as $gitem}
                                        <div class="col-4">
                                            <a href="{$gitem.url|glide:'f=webp'}" data-fancybox="{$item.alias}">
                                                <img loading="lazy" src="{$gitem.url|glide:'w=78&h=78&fit=crop&fm=webp'}" width="78" height="78" class="img-fluid" alt="{$item->name}">
                                            </a>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                            {/if}

                        </div>
                    </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const navCarousel = document.getElementById('navCarousel');
            navCarousel
                .addEventListener('click', (e) => {
                    let target = e.target;
                    let slide = target.dataset.slide;

                    navCarousel.querySelectorAll('.slide-item').forEach(item => {
                        item.classList.remove('active');
                    });
                    target.classList.add('active');
                    leadersCarousel.goTo(slide);
                });

            const leadersCarousel = Carousel(document.getElementById("leaders-carousel"), {
                adaptiveHeight: true,
                on: {
                    change: (instance) => {
                        const pageIndex = instance.getPageIndex();
                        navCarousel.querySelectorAll('.slide-item').forEach(item => {
                            item.classList.remove('active');
                        });
                        document.querySelector('.slide-item[data-slide="'+pageIndex+'"]').classList.add('active');
                    },
                },
            }).init();
        });
    </script>
    <style>
        #leaders-carousel p {
            font-size: 12px;
            line-height: 14px;
        }
        #navCarousel .slide-item {
            cursor: pointer;
        }
        #navCarousel .slide-item.active {
            font-size: 20px;
        }
    </style>
</section>
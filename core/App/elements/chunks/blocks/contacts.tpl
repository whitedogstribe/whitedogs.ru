<section class="contacts-section mt-5 pt-5">
    <div class="container">
        <div class="row">
            <div class="col-12 mb-5">
                <h1 class="font-cofo h0 text-uppercase">{$title ?: $modx->resource->pagetitle}</h1>
            </div>

            <div class="col-12 col-lg-4 mb-5 mb-lg-0">
                <p class="text-muted d-block mb-4">Как с нами связаться:</p>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-1 gy-3 mb-5">
                    {if $modx->config.phone}
                        <div class="d-flex flex-column gap-2">
                            <small class="text-muted">Запись по телефону:</small>
                            <h5>
                                <a class="fw-bold" href="tel:{$modx->config.phone|phone}">{$modx->config.phone}</a>
                            </h5>
                        </div>
                    {/if}
                    {if $modx->config.telegram}
                        <div class="d-flex flex-column gap-2">
                            <small class="text-muted">Напишите нам в Telegram:</small>
                            <h5>
                                <a class="fw-bold" href="https://t.me/{$modx->config.telegram|replace:'@':''}" rel="nofollow">{$modx->config.telegram}</a>
                            </h5>
                        </div>
                    {/if}
                    {if $modx->config.whatsapp}
                        <div class="d-flex flex-column gap-2">
                            <small class="text-muted">Напишите нам в WhatsApp:</small>
                            <h5>
                                <a class="fw-bold" href="https://wa.me/{$modx->config.whatsapp|phone}" rel="nofollow">{$modx->config.whatsapp}</a>
                            </h5>
                        </div>
                    {/if}
                    {if $modx->config.business_telegram}
                        <div class="d-flex flex-column gap-2">
                            <small class="text-muted">Сотрудничество (Telegram):</small>
                            <h5>
                                <a class="fw-bold" href="https://t.me/{$modx->config.business_telegram|phone}" rel="nofollow">{$modx->config.business_telegram}</a>
                            </h5>
                        </div>
                    {/if}
                </div>

                <div class="d-none d-lg-block pe-5">
                    {insert 'file:chunks/forms/contact.tpl'}
                </div>
            </div>

            <div class="col-12 col-lg-8">
                <p class="text-muted d-block mb-4">Мы в соц-сетях:</p>
            
                <div class="row g-4">
            
                    {foreach $socials as $item}
                    
                        <div class="col-12 col-md-6">
            
                            <div class="d-flex gap-4 align-items-start">
            
                                {set $img = $item.img|fromJSON}
                                {set $btn = $item.btn ? ($item.btn|fromJSON) : ''}
            
                                <img loading="lazy"
                                     width="{$img.width}"
                                     height="{$img.height}"
                                     src="{$img.url}"
                                     alt="{$item.title}"
                                     class="flex-shrink-0">
            
                                <div class="d-flex flex-column gap-2 align-items-start">
                                    <p class="mb-0">{$item.supratitle}</p>
                                    <h5 class="mb-0">{$item.title}</h5>
                                    <small>{$item.description}</small>
            
                                    {if $item.link && $item.btn}
                                        <a href="{$item.link}"
                                           class="btn btn-sm btn-outline-secondary"
                                           target="_blank">
                                            {$item.btn}
                                        </a>
                                    {/if}
                                </div>
            
                            </div>
            
                        </div>
            
                    {/foreach}
            
                </div>
            </div>

            <div class="col-12 d-block d-lg-none">
                {insert 'file:chunks/forms/contact.tpl'}
            </div>

        </div>
    </div>
    <style>
        .social-slider {
            min-height: 170px;
        }

        .contacts .f-carousel__cover {
            background-size: cover !important;
            background-position: 50% 40%;
        }

        .contacts .f-carousel__dots {
            margin-top: -30px;
            color: white;
        }

        .f-carousel__dot.is-selected:after {
            width: 24px;
            border-radius: 10px;
        }

        @media (max-width: 991.98px) {

        }

        @media (max-width: 767.98px) {
            .contacts-section .h0 {
                font-size: 2rem;
            }
        }

        @media (max-width: 575.98px) {
            .contacts-section .h0 {
                font-size: 1.5rem;
            }
        }
    </style>
</section>
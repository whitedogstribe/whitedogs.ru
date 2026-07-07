{set $img = $modx->resource->image}
{set $video = $modx->resource->video|fromJSON}
{set $country = $modx->resource->country|fromJSON}
{set $city = $modx->resource->city|fromJSON}
{set $fourthImage = $modx->resource->images[3]}
<section class="hero-section py-5 px-2" style="background-image: url('{$img.url|glide:'w=1920&h=1080&fit=crop&fm=webp'}')">

    {if $video}
        <video autoplay="" class="hero-video position-absolute inset-0 object-cover w-100" loop="" muted="" playsinline="" poster="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" preload="metadata">
            <source src="{$video.url}" type="video/mp4">
        </video>
    {/if}

    <div class="container h-100 pt-3">
        <div class="row h-100 position-relative z-100">
            <div class="content col-12 col-xl-8 mx-auto d-flex flex-column text-center text-white pt-5">
                <div class="text-center d-flex flex-column my-auto">
                    <div class="col-auto">
                        {if $modx->resource->dates|length > 1}
                            {insert 'file:chunks/layout/select-dates.tpl'}
                        {else}
                            <span class="fw-bold d-block mb-4">{$modx->resource->date_range}</span>
                        {/if}
                    </div>
                    {if $modx->resource->countries && $modx->resource->countries[0]}
                        <h6 class="mb-2">{$country.name}, {$modx->resource->countries|countryNames}</h6>
                    {else}
                        <h6 class="mb-2">{$country.name}, {$city.name}</h6>
                    {/if}
                    <h1 class="font-cofo text-white mb-5 pb-5">{$modx->resource->title}</h1>
                </div>

                <div class="d-flex flex-column gap-2 mt-auto mb-5">
                    {if $modx->resource->discount}
                        <div class="d-flex flex-wrap gap-3 align-items-center justify-content-center justify-content-sm-start text-white bg-black mx-auto py-2 px-3 rounded-3">
                            <div class="d-flex flex-column">
                                <span class="h2 text-danger text-decoration-line-through m-0 tour-old-price">{$modx->resource->old_price}</span>
                                <span class="h3 fw-bold m-0">-<span class="tour-discount">{$modx->resource->discount}</span>%</span>
                            </div>
                            <span class="font-cofo price">{$modx->resource->price}</span>
                        </div>
                    {else}
                        <span class="font-cofo price">{$modx->resource->price}</span>
                    {/if}
                    <div class="d-flex justify-content-center align-items-center gap-2 mt-auto">
                        <span>Сложность:</span>
                        <div class="d-flex gap-1 difficulty">
                            {set $level = $modx->resource->level|default:0}
                            {foreach range(1,5) as $i}
                                <span class="dot{if $i <= floor($level)} full{elseif $i == $level + 0.5} half{/if}"></span>
                            {/foreach}
                        </div>
                    </div>
                    <small class="small-12">{$.pb.tour_level[$modx->resource->level]}</small>
                </div>

                <button type="button"
                        class="btn btn-danger mx-auto text-uppercase rounded-pill fw-bold px-5 py-3"
                        data-bs-toggle="modal"
                        data-bs-target="#modal-signup"
                        data-id="{$modx->resource->id}"
                        data-title="{$modx->resource->title}"
                        data-url="{$modx->config.site_url}{$modx->resource->uri}"
                        data-price="{$modx->resource->price}"
                >Записаться в поход</button>
            </div>
        </div>
    </div>
    <div class="position-absolute overflow-hidden start-0 w-100 z-99" style="bottom:-2px; color: rgb(245, 245, 245)">
        <svg height="auto" width="100%" data-icon="section-slope" viewBox="0 0 2202 240">
            <use href="#section-slope"></use>
        </svg>
    </div>

    <style>
        .hero-section {
            min-height: 660px;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .hero-section video {
            height: 100%;
            object-fit: cover;
        }
        .hero-section:before {
            content:'';
            position: absolute;
            z-index: 10;
            inset: 0;
            background: #092c2e;
            opacity: .6;
        }
        .hero-section .content {
            height: calc(100% + 2rem);
        }
        .hero-section .price {
            font-size: 3.75rem;
        }

        @media (min-width: 1200px) {
            .hero-section h1 {
                font-size: 60px;
                line-height: 60px;
            }
        }
        @media (max-width: 768px) {
            .hero-section .price {
                font-size: 2.75rem;
            }
            .hero-video {
                display: none;
            }
            .hero-section {
                background-image: url('{$fourthImage.url|glide:"w=768&h=1000&fit=crop&fm=webp"}') !important;
                background-position: center
            }
        }
        
        
    </style>
</section>
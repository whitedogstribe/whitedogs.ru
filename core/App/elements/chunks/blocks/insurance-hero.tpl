<section class="hero-section pt-4 pb-5 px-2 d-flex align-items-center" style="background-image: url('{$img.url|glide:'w=1920&h=1080&fit=crop&fm=webp'}')">
    <div class="container h-100 position-relative py-5 z-100">
        <div class="row h-100">
            <div class="col-12 col-md-8 mx-auto d-flex flex-column align-items-center text-center text-white">
                <div class="text-center py-5 my-5">
                    <div class="col-auto">
                        <h1 class="font-cofo text-white mb-3">{$modx->resource->insurance_title ?: ('Оформить страховку на ' ~ $modx->resource->title)}</h1>
                        <h2 class="h5">Туристическая страховка {$country.name}, {$city.name}</h2>
                    </div>
                </div>
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
            overflow: hidden;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .hero-section:before {
            content:'';
            position: absolute;
            z-index: 10;
            inset: 0;
            background: #092c2e;
            opacity: .6;
        }

        @media (min-width: 1200px) {
            .hero-section h1 {
                font-size: 36px;
                line-height: 40px;
            }
        }
    </style>
</section>
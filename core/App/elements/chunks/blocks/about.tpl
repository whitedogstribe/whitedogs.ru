<section class="about-section bg-white py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-12">
                <h1 class="font-cofo">{$title}</h1>
                {$description}
            </div>
            <div class="col-lg-8 col-12">
                <div class="f-carousel f-carousel-default">
                    {foreach $slider as $slide}
                        <div class="f-carousel__slide rounded-4 overflow-hidden">
                            <img loading="lazy" src="{$slide.url|glide:'w=856&h=364&fit=crop&fm=webp'}" width="856" height="364" alt="{$slide.name}">
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    <style>
       
       
        @media (max-width: 768px) {
            .f-carousel__slide {
                display: flex;
                justify-content: center;
                align-items: center;
            }
        
            .f-carousel__slide img {
                width: auto;
                max-width: 100%;
                height: auto;
            }
        }
        
        
    </style>
</section>
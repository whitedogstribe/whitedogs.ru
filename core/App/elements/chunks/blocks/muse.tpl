<section class="muse-section pt-4 pb-5">
    <h2 class="font-cofo text-center text-uppercase mb-5 px-4">{$title}</h2>

    <div class="f-carousel" id="muse-carousel">
        {foreach $items as $item}
            {set $img = ''}
            {if $item.img}
                {set $img = $item.img|fromJSON}
            {/if}
            <div class="f-carousel__slide{if $img} f-carousel__slide--img{/if}"{if $img} style="background-image: url({$img.url|glide:'w=340&h=220&fit=crop&fm=webp'})"{/if}>
                <h5 class="d-flex justify-content-center w-100 h-100 mb-0 text-center p-5 align-items-center">
                    <a href="/tours/{$item.tour}"{if $img} class="text-white"{/if}>{$item.title}</a>
                </h5>
            </div>
        {/foreach}
    </div>


    <style>
        #muse-carousel {
            --f-carousel-slide-width: 340px;
            --f-carousel-slide-height: 220px;
            --f-carousel-gap: 10px;
        }
        .muse-section  .f-carousel__slide {
            background-color: #D9D9D9;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
        }
        .muse-section  .f-carousel__slide--img:before {
            content:'';
            position: absolute;
            inset:0;
            background: rgba(0,0,0,.2);
            z-index: -1;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const muse_carousel = document.getElementById("muse-carousel");
            Carousel(muse_carousel, {
                center: 1,
                Autoscroll: {
                    speed : 3,
                    speedOnHover: 0
                }
            }, { Dots, Autoscroll }).init();
        })
    </script>
</section>
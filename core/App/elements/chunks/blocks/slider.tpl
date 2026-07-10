<section class="slider-section">

    {set $ids = []}
    {foreach $slides as $slide}
        {set $ids[] = $slide.tour}
    {/foreach}

    <div class="f-carousel f-carousel-default" id="tour-carousel">
        {set $bg = $bg|fromJSON}
        <div class="f-carousel__slide f-carousel__cover" style="background-image:url({$bg.url|glide:'w=1920&q=75&fm=webp'})">
            <div class="f-carousel__slide-content my-5 mx-auto text-center text-white px-3 py-5">
                <h2 class="h0 font-cofo text-uppercase text-white mb-4">{$title}</h2>
                <input
                        type="text"
                        id="sliderSearchInput"
                        class="form-control rounded-5 mx-auto px-4 py-3 bg-white text-center"
                        placeholder="Хочу в поход по любви"
                        autocomplete="off"
                >
            </div>
        </div>

        {if $ids}
            {set $tours = tours($ids)}
            {foreach $tours as $idx => $tour}
                {set $slideImg = $slides[$idx]['img'] ?: ''}
                {if $slideImg}
                    {set $img = $slideImg|fromJSON}
                {else}
                    {set $img = $tour.image}
                {/if}
                {set $video = $tour.data.video|fromJSON}
                <div class="f-carousel__slide{$video ? ' f-carousel__slide--video' : ''}" style="background-image:url({$img.url|glide:'w=1920&q=75&fm=webp'})">
                    {if $video}
                        <video class="f-carousel__slide-video" autoplay loop muted playsinline preload="metadata"
                               poster="{$img.url|glide:'w=1920&h=1080&fit=crop&fm=webp'}">
                            <source src="/{$video.url}" type="video/mp4">
                        </video>
                    {/if}
                    <div class="f-carousel__slide-content text-center text-white px-3 py-5">
                        <h5 class="mb-5">{$tour.date_range} | {$tour.country_name}, {$tour.city_name}</h5>
                        <h2 class="h0 font-cofo text-uppercase text-white mb-5">{$tour.title}</h2>
                        <a href="{route('tour.show', ['alias' => $tour.alias])}" class="btn btn-outline-light btn-radius d-inline-block btn-big mx-auto">{$slides[$idx]['btn'] ?: 'Смотреть программу'}</a>
                    </div>
                </div>
            {/foreach}
            <div class="f-carousel-nav-wrap">
                <button class="f-carousel-nav" data-carousel-go-prev aria-label="Назад">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="15 18 9 12 15 6"/>
                    </svg>
                </button>
                <button class="f-carousel-nav" data-carousel-go-next aria-label="Вперёд">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="9 18 15 12 9 6"/>
                    </svg>
                </button>
            </div>
        {/if}
    </div>

    <style>
        #tour-carousel {
            height: 100%;
        }
        #tour-carousel .f-carousel__slide {
            position: relative;
            width: 100%;
            height: 100%;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #tour-carousel .f-carousel__slide-content {
            max-width: 800px;
            width: 100%;
        }
        .f-carousel__slide-video {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 0;
        }
        #tour-carousel .f-carousel__slide:before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at center, rgba(0,0,0,.55) 0%, rgba(0,0,0,.1) 70%, transparent 100%);
            pointer-events: none;
            z-index: 1;
        }
        #tour-carousel .f-carousel__slide-content {
            position: relative;
            z-index: 2;
        }
        .f-carousel-nav-wrap {
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
            pointer-events: none;
            z-index: 100;
        }
        .f-carousel-nav {
            background: rgba(255,255,255,.18);
            backdrop-filter: blur(6px);
            border: 1px solid rgba(255,255,255,.35);
            border-radius: 50%;
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            pointer-events: all;
            cursor: pointer;
            transition: background .2s;
        }
        .f-carousel-nav:hover {
            background: rgba(255,255,255,.32);
        }
        #tour-carousel  .f-carousel__dots {
            bottom: 20px;
            top: auto;
            color: #fff;
        }
        .f-carousel.has-dots {
            margin: 0
        }
        
        .slider-section {
            height: 100vh;
            min-height: 660px;
        }
        
        @media (min-width: 768px) {
            .slider-section {
                height: 100vh;
                min-height: 660px;
            }
        }
        @media (max-width: 768px) {
            .slider-section .h0{
                margin-top:100px
            }
        }
    </style>
    <script>
        function animatePlaceholder(inputId, phrases, { speed = 100, pauseMs = 2000 } = {}) {
            const input = document.getElementById(inputId);
            if (!input) return;

            const cursor = '|';
            let phraseIndex = 0;
            let charIndex = 0;
            let typing = true;

            function tick() {
                if (document.activeElement === input) {
                    input.placeholder = '';
                    setTimeout(tick, 300);
                    return;
                }

                const text = phrases[phraseIndex];

                if (typing) {
                    charIndex++;
                    input.placeholder = text.slice(0, charIndex) + cursor;

                    if (charIndex >= text.length) {
                        typing = false;
                        setTimeout(tick, pauseMs);
                        return;
                    }
                } else {
                    charIndex--;
                    input.placeholder = text.slice(0, charIndex) + cursor;

                    if (charIndex === 0) {
                        typing = true;
                        phraseIndex = (phraseIndex + 1) % phrases.length; // следующая фраза
                        setTimeout(tick, 400);
                        return;
                    }
                }

                setTimeout(tick, typing ? speed : speed / 2);
            }

            tick();
        }
        document.addEventListener('DOMContentLoaded', () => {
            animatePlaceholder('sliderSearchInput', [
                'Хочу в поход по любви',
                'Хочу на восхождение по любви',
                'Хочу в поход с детьми',
            ], { speed: 85, pauseMs: 2200 });
        })
    </script>
</section>
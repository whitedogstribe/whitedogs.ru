{insert 'file:chunks/svg.tpl'}
<section class="hero-blur-section px-2 d-flex align-items-center overflow-hidden">

    <div class="position-absolute inset-0">
        <img src="data:image/webp;base64,UklGRm4BAABXRUJQVlA4IGIBAACwBwCdASooABYAPpE6l0kloyIhKrgN+LASCUATple2b8UiqfjeYK5QKk/RCp9rJZyzm77qhkD0CyNztvllVTDUeeEP6GAAAP71mXzoQK5mmMeLZ89T0L8Sl8Y2jfnNH9pcELLCNQ4kAxmmiaoCfgDNVVNDkptVaGGIhtVe1Bf/w7tK/FSpB5cXd/75XZCf6i4hUyzRmusp4QGfRDS1uBTFhiJURravL/SGxTcQECrYQyRqr3ToHoYE5BaMIwL73uN2A2SzJK4LreKmTs5P87VNPj3DPHFahiaAWEukkiiWkQnxsL+vBWimSh9dQPyInDyunAamHthDuCjmGAYvqDW3/kTCVTozG+6eWeP25VGZz+fpu6QisO8DMBMBJ8hxKcPwhMzqhnzpn8D31W9UAj/dD1TY4EFd8ink6c4ULqEiIPA6rkGRmDdE9u19iw/RKLtPWcvyBqn0X6yBrIivlAOIAAA="
             class="position-absolute w-100 h-100 inset-0"
             alt="">
    </div>
    {if $title}
    <div class="container py-5 h-100 position-relative z-100">
        <div class="row h-100 py-5">
            <div class="col-12 col-md-8 mx-auto py-5">
                <div class="text-center py-5">
                    <h1 class="font-cofo h0 text-white mb-0">{$title}</h1>
                </div>
            </div>
        </div>
    </div>
    {/if}

    <div class="position-absolute overflow-hidden start-0 w-100 z-99" style="bottom:-2px; color: rgb(245, 245, 245)">
        <svg height="auto" width="100%" data-icon="section-slope" viewBox="0 0 2202 240">
            <use href="#section-slope"></use>
        </svg>
    </div>
    <style>
        .hero-blur-section {
            min-height: 200px;
        }
        .hero-blur-section img {
            filter: blur(8px);
            object-fit: cover;
        }
    </style>
</section>
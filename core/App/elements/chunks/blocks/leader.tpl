<section class="leader-section pt-5 my-5" style="background-color: #F0EDED">
    <div class="container position-relative">
        <div class="row">
            <div class="col-12 col-lg-4 pb-5 text-center text-lg-start">
                <h3 class="fw-bold mb-4">{$title}</h3>
                <p class="h5">{$description}</p>
                <a href="{urlName('team')}" class="btn btn-big btn-radius btn-outline-dark mx-auto mx-lg-0">Наша команда</a>
            </div>
            <div class="d-flex align-items-center col-12 col-lg-auto mx-auto position-relative">
                {set $img = $img|fromJSON}
                <img loading="lazy"
                     src="{$img.url|glide:'f=webp'}"
                     class="img-fluid mx-auto"
                     width="330"
                     alt="{$title}">

                {if $video}
                    {set $video = $video|fromJSON}
                    <div class="position-absolute top-50 start-50 translate-middle">
                        <a href="{$video.url}" data-fancybox>
                            <i class="bi bi-play-circle text-white" style="font-size: 70px"></i>
                        </a>
                    </div>
                {/if}
            </div>
            <div class="col-4 d-none d-lg-block"></div>
        </div>
    </div>
    <style>
        .leader-section h3 {
            max-width: 250px;
        }
        .leader-section p {
            max-width: 375px;
            margin-bottom: 40px;
            line-height: 35px;
            font-weight: 500;
        }
        @media (max-width: 991.98px) {
            .leader-section h3,
            .leader-section p {
                max-width: 100%;
            }
        }
    </style>
</section>
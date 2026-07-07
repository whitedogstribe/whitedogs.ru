<section class="who_we_are bg-mauve mb-5" style="background-image: url({'/assets/images/wwa.png'|glide:'f=webp'})">
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h3 class="mb-4">{$title}</h3>
                {if $description}
                    <p class="h5">{$description}</p>
                {/if}
                {set $btn = $btn|fromJSON}
                {if $btn && $btn.published}
                    <a href="/{$btn.resource ?: $btn.href}?view=list" class="btn btn-big btn-radius btn-outline-dark d-inline-block">{$btn.caption}</a>
                {/if}
            </div>
        </div>
    </div>
    <style>
        .who_we_are {
            overflow: hidden;
            background-repeat: no-repeat;
            background-position: 100% 100%;
            background-size: 65vw;
        }
        .who_we_are h3 {
            max-width: 590px;
            font-weight: bold;
            line-height: 35px;
        }
        .who_we_are p {
            max-width: 692px;
            margin-bottom: 40px;
            line-height: 30px;
        }

        @media (max-width: 991.98px) {
            .who_we_are {
                background-image: none !important;
            }
        }

        @media (max-width: 767.98px) {
            .who_we_are h3 {
                font-size: 1.2rem;
                line-height: 1.6;
                max-width: 100%;
            }
            .who_we_are p {
                font-size: 1rem;
                line-height: 1.6;
                max-width: 100%;
            }
        }
    </style>
</section>
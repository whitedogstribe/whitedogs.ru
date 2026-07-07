{set $img = $bg|fromJSON}
<section class="cta-section text-white bg-cover" style="background-image: url({$img.url|glide:'w=1920&fit=crop&fm=webp'})">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-7 mx-auto text-center">
                <h2 class="h0 font-cofo text-uppercase text-white">{$title}</h2>
            </div>
            <div class="col-12 col-xl-7 mx-auto d-flex flex-column text-center">
                {if $description}
                    <p class="cta-description rounded-3">{$description}</p>
                {/if}

                <div class="d-flex flex-wrap justify-content-center gap-3" style="margin-top: 290px">
                    <a href="https://t.me/whitedogstribe" target="_blank" class="btn btn-big btn-radius btn-blur">Задать вопрос</a>
                    <a href="/calendar" class="btn btn-big btn-radius btn-primary">Хочу в путешествие!</a>
                </div>
            </div>
        </div>
    </div>
    <style>
        .cta-section {
            padding: 5rem 0;
            background-repeat: no-repeat;
        }
        .cta-description {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            padding: 10px;
            max-width: 468px;
            margin: auto;
        }
        .cta-section .font-cofo {
            margin-bottom: 55px;
        }
    </style>
</section>
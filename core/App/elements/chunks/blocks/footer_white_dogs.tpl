<section class="white-dogs pt-4">
    <div class="container">
        <div class="row">
            <div class="col-12 col-sm-3 order-1 position-relative">
                {if $description}
                    <small class="description">{$description}</small>
                {/if}
            </div>
            <div class="col-12 col-sm-6 order-5 order-sm-2">
                <div class="text-center">
                    <img loading="lazy" class="white-dogs-img img-fluid" src="/assets/images/content/contacts/white-dogs.svg" alt="">
                </div>
            </div>
            <div class="col-12 col-sm-3 order-3 position-relative">
                <div class="logo d-flex align-items-center gap-3">
                    <small>
                        С ожиданием, <br>
                        Племя Белых Псов
                    </small>
                    <img loading="lazy" src="/assets/images/logo.svg" width="33" height="28" alt="{'site_name'|config}">
                </div>
            </div>
        </div>
    </div>
    <style>
        .white-dogs .description,
        .white-dogs .logo {
            position: absolute;
            top: 50%;
            right: -50%;
            max-width: 307px;
            transform: translateY(-50%);
        }
        .white-dogs .logo {
            left: -30%;
            right: 0;
        }
        .white-dogs-img {
            transform: translate(0, 12px);
        }

        @media (max-width: 575.98px) {
            .white-dogs .description,
            .white-dogs .logo {
                position: relative;
                top: 0;
                right: 0;
                left: 0;
                transform: none;
                display: block;
                margin: 0 auto 20px;
                text-align: center;
                justify-content: center;
            }
        }
    </style>
</section>
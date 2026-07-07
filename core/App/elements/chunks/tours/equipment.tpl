<section class="equipment-section pb-5 overflow-hidden" id="equipment">

    <div class="equipment-header position-relative">
        <div class="position-absolute overflow-hidden start-0 w-100 z-100 text-white" style="top:-2px">
            <svg height="auto" width="100%" class="svg-section-top" data-icon="section-slope" viewBox="0 0 2202 240">
                <use href="#section-slope"></use>
            </svg>
        </div>
        <div class="position-absolute inset-0" style="background: url('/assets/images/backpack-bg.f6d47dbce286940183a43e8a19e8ef32.webp') center center/cover"></div>

        <div class="container position-relative z-100 py-5 mx-auto text-white">
            <div class="row pt-5 h-100">
                <div class="col-12 d-flex flex-column pt-5">
                    <h2 class="equipment-title h1 text-center text-uppercase font-cofo mt-5">Что положить в рюкзак</h2>
                    <div class="mt-auto mb-5">
                        <h3 class="h5 fw-semibold">{$modx->resource->backpack_title}</h3>
                        <ul class="equipment-info d-flex gap-3 p-0 list-unstyled mb-4">
                            <li>- обязательно</li>
                            <li style>- по желанию</li>
                        </ul>
                        <hr class="doted">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="equipment-content position-relative pb-5">
        <div class="equipment-bg"></div>
        <div class="container position-relative pb-mb-5 mb-3 text-white">
            <div class="row">
                <div class="col-12 col-md-6 col-lg-4">
                    {if $modx->resource->backpack_eqip}
                        <div class="equipment-item mb-5">
                            <div class="d-flex gap-3 align-items-center mb-3 ps-3">
                                <img loading="lazy" src="/assets/images/content/icons/eq-backpack.svg" width="48" height="50" alt="Личное снаряжение">
                                <h6 class="m-0">Личное <br>снаряжение</h6>
                            </div>
                            {$modx->resource->backpack_eqip|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                        </div>
                    {/if}
                    {if $modx->resource->backpack_gigiena}
                        <div class="equipment-item mb-5">
                            <div class="d-flex gap-3 align-items-center mb-3 ps-3">
                                <img loading="lazy" src="/assets/images/content/icons/eq-brush-teeth.svg" width="50" height="50" alt="Предметы гигиены">
                                <h6 class="m-0">Предметы <br>гигиены</h6>
                            </div>
                            {$modx->resource->backpack_gigiena|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                        </div>
                    {/if}
                </div>
                <div class="col-12 col-md-6 col-lg-4">
                    {if $modx->resource->backpack_clothes}
                        <div class="equipment-item mb-5">
                            <div class="d-flex gap-3 align-items-center mb-3 ps-3">
                                <img loading="lazy" src="/assets/images/content/icons/eq-boots.svg" width="51" height="37" alt="Одежда и обувь">
                                <h6 class="m-0">Одежда <br>и обувь</h6>
                            </div>
                            {$modx->resource->backpack_clothes|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                        </div>
                    {/if}
                </div>
                <div class="col-12 col-lg-4">
                    <div class="row">
                        {if $modx->resource->backpack_paper}
                            <div class="col-12 col-md-6 col-lg-12">
                                <div class="equipment-item mb-5">
                                    <div class="d-flex gap-3 align-items-center mb-3 ps-3">
                                        <img loading="lazy" src="/assets/images/content/icons/eq-phone-charge.svg" width="41" height="50" alt="Гаджеты и бумаги">
                                        <h6 class="m-0">Гаджеты <br>и бумаги</h6>
                                    </div>
                                    {$modx->resource->backpack_paper|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                                </div>
                            </div>
                        {/if}
                        {if $modx->resource->backpack_apteka}
                            <div class="col-12 col-md-6 col-lg-12">
                                <div class="equipment-item mb-5">
                                    <div class="d-flex gap-3 align-items-center mb-3 ps-3">
                                        <img loading="lazy" src="/assets/images/content/icons/eq-first-aid-kit.svg" width="41" height="40" alt="Индивидуальная аптечка">
                                        <h6 class="m-0">Индивидуальная <br>аптечка</h6>
                                    </div>
                                    {$modx->resource->backpack_apteka|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-auto mx-auto">
                    <div class="text-center">
                        <a href="{7|url}" class="btn btn-success py-3 rounded-5">
                            <span class="px-4 fw-bold">Аренда снаряжения</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="position-absolute overflow-hidden pe-none start-0 w-100 text-white" style="bottom:-2px">
        <svg height="auto" width="100%" data-icon="section-slope" viewBox="0 0 2202 240">
            <use href="#section-slope"></use>
        </svg>
    </div>
    <style>
        .equipment-title {
            margin-bottom: 12rem;
        }
        .equipment-item a {
            color: var(--color-success);
        }
        .equipment-item h6 {
            line-height: 24px;
        }
        .equipment-bg {
            position: absolute;
            background-color: #423E45;
            filter: blur(16px);
            margin: -50px 0 0;
            left: -50px;
            right: -50px;
            bottom: -200px;
            z-index: 0;
            height: calc(100% + 250px);
        }
        .equipment-section ul {
            list-style: none;
        }
        .equipment-section li {
            font-size: 14px;
            line-height: 20px;
            margin-bottom: 7px;
            color: #fff;
        }
        .equipment-section li[style] {
            opacity: .7;
        }
        .equipment-section li:before {
            content: "";
            position: relative;
            top: -3px;
            display: inline-block;
            width: 6px;
            height: 6px;
            background-color: #20c19c;
            border-radius: 100%;
            margin-right: 1rem;
        }
        .equipment-section li[style]:before {
            background-color: #9597a2;
        }
        .equipment-info li {
            display: flex;
            align-items: center;
        }
        .equipment-info li:before {
            margin-right: 5px;
            top: 0;
        }
        @media (max-width: 575.98px) {
            .equipment-title {
                font-size: 36px;
            }
        }
    </style>
</section>
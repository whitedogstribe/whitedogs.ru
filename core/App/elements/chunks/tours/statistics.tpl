<section class="stats-section bg-light-gray py-4">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-4 col-md-3 mb-4">
                <div class="stat-card">
                    <small class="text-muted">Как высоко?</small>
                    <div class="stat-icon">
                        <img loading="lazy" width="64" height="64" src="/assets/images/content/icons/stats-mountain.svg" alt="Как высоко">
                    </div>
                    <div class="d-flex flex-column">
                        <span class="h4 mb-0 fw-bold">{$modx->resource->altitude}</span>
                        <span class="fw-bold lh-half">{$modx->resource->altitude|decl:'метр|метра|метров'}</span>
                    </div>
                </div>
            </div>

            <div class="col-4 col-md-3 mb-4">
                <div class="stat-card">
                    <small class="text-muted">Сколько топать?</small>
                    <div class="stat-icon">
                        <img loading="lazy" width="48" height="48" src="/assets/images/content/icons/stats-route.svg" alt="Сколько топать">
                    </div>
                    <div class="d-flex flex-column">
                        <span class="h4 mb-0 fw-bold">{$modx->resource->distance}</span>
                        <span class="fw-bold lh-half">км</span>
                    </div>
                </div>
            </div>

            <div class="col-4 col-md-3 mb-4">
                <div class="stat-card">
                    <small class="text-muted">Надолго?</small>
                    <div class="stat-icon">
                        <img loading="lazy" width="48" height="48" src="/assets/images/content/icons/stats-calendar.svg" alt="Надолго">
                    </div>
                    <div class="d-flex flex-column">
                        <span class="h4 mb-0 fw-bold">{$modx->resource->days}</span>
                        <span class="fw-bold lh-half">дней</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .stat-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-icon {
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
            width: 64px;
            height: 64px;
        }
    </style>
</section>
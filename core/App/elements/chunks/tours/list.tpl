{set $img = $tour.image}

<div class="col-12 mb-4">
    <div class="row flex-column flex-xl-row align-items-xl-center g-2">

        {set $nd = $tour->nearestDate}
        <div class="col-xl-auto tour-list-date">
            <div class="d-flex align-items-start gap-3">
                <i class="bi bi-calendar3"></i>
                <div class="d-flex flex-column gap-1">
                    <small>{$tour.date_range_simple}</small>
                    <small>({$tour.days_count} {$tour.days_count|decl:'день|дня|дней'})</small>
                </div>
            </div>
        </div>

        <div class="col-xl d-flex gap-3">
            <a href="/tours/{$tour.alias}" class="flex-shrink-0">
                <img loading="lazy" class="rounded-2" width="100" height="80" src="{$img.url|glide:'w=100&h=80&fit=crop&fm=webp'}">
            </a>
            <div class="d-flex flex-column gap-1">
                <div class="d-flex d-xl-none align-items-center gap-3">
                    <i class="bi bi-calendar3"></i>
                    <div class="d-flex flex-wrap gap-1">
                        <small>{$tour.date_range_simple}</small>
                        <small>({$tour.days_count} {$tour.days_count|decl:'день|дня|дней'})</small>
                    </div>
                </div>
                <h2 class="fw-bold h5 mb-0">
                    <a class="btn-hidelink{$tour.status == 'closed' ? ' text-secondary' : ''}" href="/tours/{$tour.alias}?start_date={$tour->start_date|date:'Y-m-d'}">{$tour.title}</a>
                </h2>
                <small class="fw-bold text-muted">{$tour.country_name}, {$tour.city_name}</small>
            </div>
        </div>

        <div class="col-xl-auto d-flex align-items-center gap-3 justify-content-end tour-list-actions">
            <div class="d-flex flex-column align-items-end gap-1">
                {if $tour.discount}
                    <div class="d-flex gap-2">
                        <span class="fw-bold text-decoration-line-through">{$tour.old_price}</span>
                        <span class="fw-semibold text-danger">-{$tour.discount}%</span>
                    </div>
                    <span class="fw-bold text-center text-white bg-danger h5 mb-0">{$tour.price}</span>
                {else}
                    <span class="fw-bold h5 mb-0">{$tour.price}</span>
                {/if}
                {if $nd}
                    {set $placesLeft = $nd->max_people - $nd->people}
                    {if $tour.status == 'closed'}
                        <small class="fw-semibold text-secondary">Группа набрана</small>
                    {elseif $placesLeft <= 1}
                        <small class="fw-semibold text-danger">Осталось {$placesLeft} место из {$nd->max_people}</small>
                    {elseif $placesLeft <= 2}
                        <small class="fw-semibold text-warning">Осталось {$placesLeft} места из {$nd->max_people}</small>
                    {else}
                        <small class="fw-semibold text-muted">{$nd->people}/{$nd->max_people} мест</small>
                    {/if}
                {/if}
            </div>


            {set $dates = []}
            {foreach $tour.dates as $date}
                {set $dates[] = [
                'date' => $date.date_range,
                'price' => $date.price_format
                ]}
            {/foreach}
            <button type="button"
                    class="btn btn-lg {$tour.status == 'closed' ? 'btn-secondary' : 'btn-success'}"
                    data-bs-toggle="modal"
                    data-bs-target="#modal-signup"
                    data-id="{$tour.id}"
                    data-title="{$tour.title}"
                    data-url="{$modx->config.site_url}tours/{$tour.alias}"
                    data-price="{$tour.price}"
                    data-date="{$tour.date_range}"
                    data-dates='{$dates|toJSON}'
            >{$tour.status == 'closed' ? 'В лист <br>ожидания' : 'Записаться'}</button>
        </div>

    </div>
    <hr class="d-block d-xl-none">
</div>
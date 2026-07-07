{set $img = $tour.image}
{set $date = $tour.dates[0]}
{set $status = 'success'}
{if ($date.max_people - $date.people) < 5}
    {set $status = 'danger'}
{/if}
{if $date.people == $date.max_people}
    {set $status = 'full'}
{/if}

<div class="col">
    <div class="tour-card">
        <small class="d-inline-flex align-self-start fs-12 bg-light-gray p-2 mb-2">
            {$tour.country_name} | {$tour.date_range}
        </small>
        <a href="/tours/{$tour.alias}" class="tour-card-img overflow-hidden d-block">
            {if $tour.discount}
                <small class="position-absolute top-0 end-0 fs-12 bg-danger text-white fw-bold tour-card-discount">-{$tour.discount}%</small>
            {/if}
            <img loading="lazy"
                 src="{$img.url|glide:'w=317&h=230&fit=crop&fm=webp'}"
                 width="317"
                 height="230"
                 alt="{$tour.title}"
                 class="tour-card-img-inner">
            <div class="position-absolute p-2 bottom-0 start-0 end-0">
                <div class="d-flex justify-content-between align-items-end">
                    <h6 class="tour-card-title text-white m-0 col-8 px-0">{$tour.title}</h6>
                    <div class="d-flex flex-column text-end">
                        {if $tour.discount}
                            <small class="fs-12 fw-semibold text-danger text-decoration-line-through">{$tour.old_price}</small>
                            <span class="fw-semibold text-white">{$tour.price}</span>
                        {else}
                            <span class="fw-semibold text-white">{$tour.price}</span>
                        {/if}
                    </div>
                </div>
            </div>
        </a>
        <div class="d-flex align-items-start mb-2">
            <div class="tour-card-badge status-{$status}">
                <i class="bi bi-person-standing"></i>
                <small class="fs-12 fw-bold">{$date.people} / {$date.max_people}</small>
            </div>
            {switch $status}
            {case 'success'}
                <small class="pt-1 fw-medium text-success">Идёт набор группы</small>
            {case 'danger'}
                {set $remain = $date.max_people - $date.people}
                <small class="pt-1 fw-medium text-danger">Осталось всего {$remain} {$remain|decl:'место|места|мест'}</small>
            {case 'full'}
                <small class="pt-1 fw-medium text-gray">Группа набрана</small>
            {/switch}
        </div>

        <div class="d-flex align-items-center gap-2 mb-2 ps-2">
            <small class="fw-semibold">Сложность:</small>
            <div class="d-flex rating gap-1">
                {set $level = $tour.level|default:0}
                {foreach range(1,5) as $i}
                    {if $i <= floor($level)}
                        <i class="bi bi-star-fill"></i>
                    {elseif $i == $level + 0.5}
                        <i class="bi bi-star-half"></i>
                    {else}
                        <i class="bi bi-star"></i>
                    {/if}
                {/foreach}
            </div>
        </div>

        <div class="d-flex align-items-center gap-1">
            <a href="/tours/{$tour.alias}" class="btn btn-sm btn-primary rounded-5">Узнать больше</a>
            {set $dates = []}
            {foreach $tour.dates as $date}
                {set $dates[] = [
                    'date' => $date.date_range,
                    'price' => $date.price_format
                ]}
            {/foreach}

            <button  type="button"
                     class="btn btn-link text-primary text-decoration-none{if $status == 'open'} ms-1{/if}"
                     data-bs-toggle="modal"
                     data-bs-target="#modal-signup"
                     data-id="{$tour.id}"
                     data-title="{$tour.title}"
                     data-url="{$modx->config.site_url}tours/{$tour.alias}"
                     data-price="{$tour.price}"
                     data-date="{$tour.date_range}"
                     data-dates='{$dates|toJSON}'
            >Записаться
{*                {if $status == 'full'}*}
{*                    <small class="fs-12">Записаться в лист ожидания ></small>*}
{*                {else}*}
{*                    Записаться*}
{*                {/if}*}
            </button>
        </div>
    </div>
</div>
{set $date = $tour.dates[0]}
{set $allDates = $tour.dates}
{set $extraDates = ($allDates|count) - 1}
{set $avail = $date.max_people - $date.people}
{set $cardId = 'tc-' ~ $tour.id}
{set $imgCount = $tour.images ? ($tour.images|count) : 0}
{* Статус доступности *}
{if $avail <= 0}
    {set $availStatus = 'full'}
{elseif $avail == 1}
    {set $availStatus = 'last1'}
{elseif $avail <= 2}
    {set $availStatus = 'low'}
{else}
    {set $availStatus = 'ok'}
{/if}

<div class="col">
    <div class="tc2-card" id="{$cardId}">

        <a href="/tours/{$tour.alias}" class="tc2-gallery">
            {if $imgCount > 0}
                {set $n = 0}
                {foreach $tour.images as $gimg}
                    {set $n = $n + 1}
                    {if $n <= 8}
                    <div class="tc2-slide{$n == 1 ? ' active' : ''}">
                        <img loading="{$n == 1 ? 'eager' : 'lazy'}"
                             src="{$gimg.url|glide:'w=480&h=300&fit=crop&fm=webp'}"
                             width="480" height="300"
                             alt="{$tour.title}">
                    </div>
                    {/if}
                {/foreach}
            {elseif $tour.image}
                <div class="tc2-slide active">
                    <img loading="eager"
                         src="{$tour.image.url|glide:'w=480&h=300&fit=crop&fm=webp'}"
                         width="480" height="300"
                         alt="{$tour.title}">
                </div>
            {/if}

            <div class="tc2-counter">{$imgCount > 0 ? $imgCount : 1}+</div>

            <div class="tc2-bookmark">
                <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M19 21l-7-5-7 5V5a2 2 0 012-2h10a2 2 0 012 2z"/>
                </svg>
            </div>

            {if $imgCount > 1}
                <button class="tc2-nav tc2-prev" type="button">&#8249;</button>
                <button class="tc2-nav tc2-next" type="button">&#8250;</button>
                <div class="tc2-dots">
                    {set $n = 0}
                    {foreach $tour.images as $gimg}
                        {set $n = $n + 1}
                        {if $n <= 8}
                        <span class="tc2-dot{$n == 1 ? ' active' : ''}"></span>
                        {/if}
                    {/foreach}
                </div>
            {/if}
        </a>

        <div class="tc2-body">
            <h3 class="tc2-title">{$tour.title}</h3>

            <div class="tc2-info-row">
                <svg class="tc2-icon" viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                <span>{$tour.country_name}</span>
            </div>

            <div class="tc2-info-row">
                <svg class="tc2-icon" viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                </svg>
                <span>{$tour.date_range} | {$tour.days_count} {$tour.days_count|decl:'день|дня|дней'}{if $extraDates > 0} <a href="/tours/{$tour.alias}" class="tc2-extra-dates">+ {$extraDates} {$extraDates|decl:'дата|даты|дат'}</a>{/if}</span>
            </div>

            <div class="tc2-info-row">
                {if $availStatus == 'ok'}
                    <span class="tc2-dot-green"></span>
                    <span>Доступно мест: {$avail} из {$date.max_people}</span>
                {elseif $availStatus == 'low'}
                    <span class="tc2-dot-orange"></span>
                    <span class="tc2-text-orange">Осталось {$avail} {$avail|decl:'место|места|мест'}</span>
                {elseif $availStatus == 'last1'}
                    <span class="tc2-dot-red"></span>
                    <span class="tc2-text-red">Осталось 1 место</span>
                {else}
                    <span class="tc2-dot-gray"></span>
                    <span class="tc2-text-gray">Группа набрана</span>
                {/if}
            </div>

            <div class="tc2-footer">
                {set $dates = []}
                {foreach $tour.dates as $d}
                    {set $dates[] = ['date' => $d.date_range, 'price' => $d.price_format]}
                {/foreach}
                <button type="button"
                        class="btn btn-sm {$availStatus == 'full' ? 'tc2-btn-queue' : 'btn-outline-secondary'} rounded-5"
                        data-bs-toggle="modal"
                        data-bs-target="#modal-signup"
                        data-id="{$tour.id}"
                        data-title="{$tour.title}"
                        data-url="{$modx->config.site_url}tours/{$tour.alias}"
                        data-price="{$tour.price}"
                        data-date="{$tour.date_range}"
                        data-dates='{$dates|toJSON}'
                >{$availStatus == 'full' ? 'В очередь' : 'Записаться'}</button>
                <div class="tc2-price">
                    {if $tour.discount}
                        <span class="tc2-price-old">{$tour.old_price}</span>
                    {/if}
                    {$tour.price}
                </div>
            </div>
        </div>
    </div>
</div>

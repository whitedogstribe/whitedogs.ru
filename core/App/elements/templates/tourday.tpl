{extends 'file:templates/base.tpl'}

{block 'schema'}{/block}

{block 'style'}
    <style>
        .template-tourday {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding-bottom: 100px;
        }
        .day-section {
            pointer-events: auto;
            position: relative;
            z-index: 1;
        }
        .day-section .container {
            position: relative;
            z-index: 1;
            max-width: 704px;
            margin: auto;
        }
        .footer {
            position: fixed;
            z-index: 100;
            background: #fff;
            width: 100%;
            bottom: 0;
            left: 0;
        }
        a.nav-days {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            margin: auto;
            z-index: 99;
        }
        a.nav-days.day-next {
            right: 0;
            left: auto;
        }
        .nav-days span {
            position: absolute;
            top: 50%;
            left: -56px;
            text-transform: uppercase;
            transform: translateY(-64px) matrix(0, -1, 1, 0, 0, 0);
            color: #fff;
            background: #A1A1AA;
            padding: 24px 16px 8px;
            width: 128px;
            text-align: center;
            border-radius: 12px;
            font-weight: 600;
            transition: .3s;
        }
        .day-next span {
            left: auto;
            right: -56px;
            padding: 8px 16px 24px;
        }
        .nav-days:hover span {
            background: #71717A;
            left: -46px;
        }
        .day-next:hover span {
            left: auto;
            right: -46px;
        }
        @media (max-width: 767px) {
            .template-tourday {
                padding-bottom: 0;
            }
            /*.nav-days span {*/
            /*    width: 64px;*/
            /*    padding: 12px 8px 4px;*/
            /*    font-size: 10px;*/
            /*    left: -28px;*/
            /*    transform: translateY(-32px) matrix(0, -1, 1, 0, 0, 0);*/
            /*    border-radius: 8px;*/
            /*}*/
            /*.day-next span {*/
            /*    left: auto;*/
            /*    right: -28px;*/
            /*    padding: 4px 8px 12px;*/
            /*}*/
            /*.nav-days:hover span {*/
            /*    left: -23px;*/
            /*}*/
            /*.day-next:hover span {*/
            /*    left: auto;*/
            /*    right: -23px;*/
            /*}*/
            .day-section .container-content {
                padding-left: 40px;
                padding-right: 40px;
            }
            .footer {
                position: relative;
                z-index: 0;
                padding: 0 18px;
            }
        }
        .day-nav {
            display: inline-flex;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #D4D4D8;
        }
        .day-nav:before,
        .day-nav:after {
            content: '';
        }
        .progress-container {
            padding: 40px 20px;
        }

        .progress-line {
            position: relative;
            height: 60px;
            display: flex;
            align-items: center;
        }

        .progress-point {
            display: flex;
            position: relative;
            width: 100%;
            height: 16px;
            cursor: pointer;
            z-index: 2;
        }
        .progress-point span {
            width: 16px;
            height: 16px;
            background: #fff;
            border: 3px solid #dee2e6;
            border-radius: 50%;
            transition: all 0.3s;
            display: flex;
            position: absolute;
            top: 0;
            bottom: 0;
            left: calc(50% - 8px);
            margin: auto;
        }
        .progress-point:before,
        .progress-point:after {
            content: '';
            display: flex;
            height: 4px;
            width: 50%;
            background: #dee2e6;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            margin: auto;
            z-index: -1;
        }

        .progress-point:after {
            left: auto;
            right: 0;
        }
        .progress-point.first:before,
        .progress-point.last:after {
            display: none;
        }

        .progress-point.active span {
            border-color: #20c997;
        }

        .progress-point.active:before,
        .progress-point.active:after,
        .progress-point.current:before {
            background: #20c997;
        }


       .progress-point.current span {
            width: 20px;
            height: 20px;
            border-width: 4px;
            border-color: #20c997;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(32, 201, 151, 0.2);
        }

        .progress-point:hover span {
            transform: scale(1.2);
        }

        .progress-line-segment {
            flex: 1;
            height: 4px;
            background: #dee2e6;
            cursor: pointer;
            transition: background 0.3s;
        }

        .progress-line-segment.active {
            background: #20c997;
        }

        .progress-line-segment:hover {
            opacity: 0.8;
        }

        .progress-item:last-child {
            flex: 0;
        }
        .gallery-item {
            position: relative;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .gallery-grid:hover .gallery-item {
            opacity: .75;
        }
        .gallery-grid .gallery-item:hover {
            opacity: 1 !important;
        }
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
    </style>
{/block}

{block 'header'}{/block}
{block 'blocks'}{/block}

{block 'content'}
    {set $tour = $modx->resource->tour}
    {set $planData = $tour->plan->toArray()}
    {set $activeDay = 1}
    {foreach $planData as $idx => $day}
        {set $day = $day['data']}
        {if $day.alias == $modx->resource->alias}
            {set $activeDay = $idx}
        {/if}
    {/foreach}
    {set $prevPage = ''}
    {set $nextPage = ''}
    {foreach $planData as $idx => $day}
        {set $day = $day['data']}
        {if $idx < $activeDay}
            {set $prevPage = $idx}
        {/if}
        {if $idx > $activeDay && $nextPage == ''}
            {set $nextPage = $idx}
        {/if}
    {/foreach}

    {set $images = $modx->resource->images}
    {set $start_date = $tour->start_date}
    <section class="day-section py-4">
        <div class="container">
            <div class="row">
                <div class="col-12 mx-auto d-flex flex-column align-items-start gap-2 mb-3 mt-3">
                    <a href="{$tour->uri}" class="btn btn-success"><i class="bi bi-arrow-left"></i> {$tour->title}</a>
                    <span class="span mt-4">{$modx->resource->day} | {$start_date|addDays:$activeDay}</span>
                    <h1 class="h3 font-cofo text-uppercase">{$modx->resource->title}</h1>
                </div>
            </div>
        </div>

        {if $images|length > 1}
        <div class="gallery-section mb-3">
            <div class="d-flex justify-content-center gap-1">
                <div class="d-flex justify-content-center gap-1">
                    <div class="d-flex flex-column gap-1">
                        {foreach $images as $idx => $item}
                            {if $idx < 2}
                                <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                                    <img loading="lazy" class="img-fluid" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                    {foreach $images as $idx => $item}
                        {if $idx > 1 && $idx < 4}
                            <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item d-none {$idx == 3 ? 'd-lg-flex' : 'd-md-flex'}">
                                <img loading="lazy" class="img-fluid" src="{$item.url|glide:'w=800&h=1200&fit=crop&fm=webp'}" alt="{$item.title}">
                            </a>
                        {/if}
                    {/foreach}
                    <div class="d-flex flex-column gap-1">
                        {foreach $images as $idx => $item}
                            {if $idx > 3 && $idx < 7}
                                <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                                    <img loading="lazy" class="img-fluid" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
            {/if}
        </div>

        <div class="container container-content">
            <div class="row">
                <div class="col-12">
                    {if $images|length == 1}
                        <a href="{$images[0].url|glide:'f=webp'}" data-fancybox="tour" class="d-flex mb-3">
                            <img loading="lazy" class="img-fluid" src="{$images[0].url|glide:'w=636&h=424&fit=crop&fm=webp'}" width="636" height="424" alt="{$modx->resource->title}">
                        </a>
                    {/if}
                    
                    {$modx->resource->content ?: $modx->resource->description}
                    
                    
                    {set $currentDay = $planData[$activeDay]['data']}
                    
                    <div class="d-flex flex-wrap align-items-center gap-2 mt-3 mb-3">
                        {if $currentDay.transfer}
                            <div class="d-flex align-items-center gap-1">
                                <img loading="lazy" src="/assets/images/content/icons/day-transfer.svg" alt="{$currentDay.transfer}">
                                <small class="fs-12">{$currentDay.transfer} км.</small>
                            </div>
                        {/if}
                    
                        {if $currentDay.crossing}
                            <div class="d-flex align-items-center gap-1">
                                <img loading="lazy" src="/assets/images/content/icons/day-hike.svg" alt="{$currentDay.crossing}">
                                <small class="fs-12">{$currentDay.crossing} км.</small>
                            </div>
                        {/if}
                    
                        {if $currentDay.up}
                            <div class="d-flex align-items-center gap-1">
                                <img loading="lazy" src="/assets/images/content/icons/day-up.svg" alt="{$currentDay.up}">
                                <small class="fs-12">{$currentDay.up} м.</small>
                            </div>
                        {/if}
                    
                        {if $currentDay.down}
                            <div class="d-flex align-items-center gap-1">
                                <img loading="lazy" src="/assets/images/content/icons/day-down.svg" alt="{$currentDay.down}">
                                <small class="fs-12">{$currentDay.down} м.</small>
                            </div>
                        {/if}
                    </div>
                    
                </div>
            </div>
        </div>
        
        
        

        {if $prevPage > -1}
            <a href="{$tour->uri}/{$planData[$prevPage]['data']['alias']}" class="d-block nav-days day-prev">
                <span>{$planData[$prevPage]['data']['day']}</span>
            </a>
        {/if}

        {if $nextPage > 0}
            <a href="{$tour->uri}/{$planData[$nextPage]['data']['alias']}" class="d-block nav-days day-next">
                <span>{$planData[$nextPage]['data']['day']}</span>
            </a>
        {/if}

    </section>
{/block}

{block 'footer'}
    <footer class="footer shadow-lg py-3 mt-auto">
        <div class="container-fluid">
            <div class="row d-flex align-items-center">
                <div class="col-12 col-md-3 text-center text-md-start mb-3 mb-md-0">
                    <button type="button"
                            data-bs-toggle="modal"
                            data-bs-target="#modal-signup"
                            data-id="{$tour.id}"
                            data-title="{$tour.title}"
                            data-url="{$modx->config.site_url}tours/{$tour.alias}"
                            data-price="{$tour.price}"
                            data-date="{$tour.date_range}"
                            class="d-inline-flex btn btn-danger py-2 px-4 fw-bold shadow-lg rounded-5">Иду!
                    </button>
                </div>
                <div class="col-12 col-md-6 text-center">
                    <h6 class="text-black">{$tour->plan_subtitle}</h6>
                    <div class="progress-line">
                        {set $totalDays = $planData|length}
                        {foreach $planData as $idx => $day}
                            {set $day = $day['data']}
                            <a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="{$day['day']}" href="{$tour->uri}/{$day.alias}" class="progress-point{if $idx == 0} first{/if}{if $idx == ($totalDays - 1)} last{/if}{$day.alias == $modx->resource->alias ? ' current' : ''}{$activeDay > $idx ? ' active' : ''}">
                                <span></span>
                            </a>
                        {/foreach}
                    </div>
                </div>
                <div class="col-12 col-md-3"></div>
            </div>
        </div>
    </footer>
{/block}
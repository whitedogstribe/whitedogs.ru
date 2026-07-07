<form action="{route('tour.filter')}" id="form-filter" method="post" class="d-flex flex-column gap-3" pb-filter>

    <label class="form-label mb-0">
        <span>Стоимость</span>
        <div class="d-flex gap-2 mt-1">
            <input type="number" name="price_min" class="form-control" placeholder="от 460$" min="0" step="100">
            <input type="number" name="price_max" class="form-control" placeholder="до 18500$" min="0" step="100">
        </div>
    </label>

    <label class="form-label">
        <span>Страна</span>
        <select name="country" class="form-select">
            <option value="">Все</option>
            {foreach countries() as $country}
                <option value="{$country->alias}">{$country->name}</option>
            {/foreach}
        </select>
    </label>


    <label class="form-label">
        <span>Тип тура</span>
        {set $types = query('tour_type')->orderBy('menuindex', 'asc')->get()->toArray()}
        <select name="type_tour" class="form-select">
            <option value="">Все</option>
            {foreach $types as $type}
                <option value="{$type->alias}">{$type->name}</option>
            {/foreach}
        </select>
    </label>

    <label class="form-label">
        <span>Инструктор</span>
        <select name="author" class="form-select">
            <option value="">Любой</option>
            {foreach instructors() as $item}
                <option value="{$item->id}">{$item->name}</option>
            {/foreach}
        </select>
    </label>

    <label class="form-label">
        <span>Сложность</span>
        {set $levels = query('tour_level')->whereNull('deleted_at')->orderBy('level', 'asc')->get()}
        <select name="level" class="form-select">
            <option value="">Любая</option>
            {foreach $levels as $lvl}
                <option value="{$lvl->level}">{$lvl->name}</option>
            {/foreach}
        </select>
    </label>

    {*            <div class="col-md-3">*}
    {*                <label class="form-label">Дата от</label>*}
    {*                <input type="date" class="form-control">*}
    {*            </div>*}

    {*            <!-- DATE TO -->*}
    {*            <div class="col-md-3">*}
    {*                <label class="form-label">Дата до</label>*}
    {*                <input type="date" class="form-control">*}
    {*            </div>*}

    {*            <!-- PRICE FROM -->*}
    {*            <div class="col-md-3">*}
    {*                <label class="form-label">Цена от ($)</label>*}
    {*                <input type="number" class="form-control" placeholder="0">*}
    {*            </div>*}

    {*            <!-- PRICE TO -->*}
    {*            <div class="col-md-3">*}
    {*                <label class="form-label">Цена до ($)</label>*}
    {*                <input type="number" class="form-control" placeholder="9999">*}
    {*            </div>*}

    <div class="form-label mb-0">
        <span>Длительность</span>
        <div class="d-flex justify-content-between small text-muted mt-1 mb-2">
            <span>от <b id="filter-day-min-label">5</b> дн.</span>
            <span>до <b id="filter-day-max-label">20</b> дн.</span>
        </div>
        <div class="range-slider-wrap">
            <input type="range" class="range-slider-input" name="day_min" id="filter-day-min" min="5" max="20" step="1" value="5">
            <input type="range" class="range-slider-input" name="day_max" id="filter-day-max" min="5" max="20" step="1" value="20">
        </div>
    </div>
    <style>
        .range-slider-wrap { position: relative; height: 20px; }
        .range-slider-input {
            position: absolute; width: 100%; height: 4px;
            background: transparent; pointer-events: none;
            -webkit-appearance: none; appearance: none; outline: none;
            top: 50%; transform: translateY(-50%);
        }
        .range-slider-input::-webkit-slider-thumb {
            -webkit-appearance: none; appearance: none;
            width: 18px; height: 18px; border-radius: 50%;
            background: #20C19C; border: 2px solid #fff;
            box-shadow: 0 0 0 1px #20C19C;
            pointer-events: all; cursor: pointer;
        }
        .range-slider-input::-moz-range-thumb {
            width: 18px; height: 18px; border-radius: 50%;
            background: #20C19C; border: 2px solid #fff;
            box-shadow: 0 0 0 1px #20C19C;
            pointer-events: all; cursor: pointer;
        }
        .range-slider-track {
            position: absolute; top: 50%; transform: translateY(-50%);
            height: 4px; background: #dee2e6; width: 100%; border-radius: 2px;
            pointer-events: none;
        }
        .range-slider-fill {
            position: absolute; top: 50%; transform: translateY(-50%);
            height: 4px; background: #20C19C; border-radius: 2px;
            pointer-events: none;
        }
    </style>
    <script>
    (function() {
        const MIN = 5, MAX = 20;
        function initRangeSlider() {
            const wrap = document.querySelector('.range-slider-wrap');
            if (!wrap) return;
            const minInput = document.getElementById('filter-day-min');
            const maxInput = document.getElementById('filter-day-max');
            const minLabel = document.getElementById('filter-day-min-label');
            const maxLabel = document.getElementById('filter-day-max-label');

            const track = document.createElement('div');
            track.className = 'range-slider-track';
            const fill = document.createElement('div');
            fill.className = 'range-slider-fill';
            wrap.insertBefore(track, wrap.firstChild);
            wrap.insertBefore(fill, wrap.firstChild);

            function update() {
                let minVal = parseInt(minInput.value);
                let maxVal = parseInt(maxInput.value);
                if (minVal > maxVal) { minVal = maxVal; minInput.value = minVal; }
                if (maxVal < minVal) { maxVal = minVal; maxInput.value = maxVal; }
                const pMin = (minVal - MIN) / (MAX - MIN) * 100;
                const pMax = (maxVal - MIN) / (MAX - MIN) * 100;
                fill.style.left = pMin + '%';
                fill.style.width = (pMax - pMin) + '%';
                minLabel.textContent = minVal;
                maxLabel.textContent = maxVal;
            }

            minInput.addEventListener('input', update);
            maxInput.addEventListener('input', update);
            update();
        }
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initRangeSlider);
        } else {
            initRangeSlider();
        }
    })();
    </script>

    <div class="col-12 d-flex align-items-center gap-2">
        <button type="submit" class="btn btn-success text-white">
            Применить
        </button>
        <button type="reset" class="btn btn-outline-secondary ms-auto">
            Сбросить
        </button>
    </div>
</form>
<select name="tour_date" class="changePrice form-select-sm fw-bold form-control form-select w-auto mb-1">
    {foreach $tour->dates as $date}
        <option value="{$date->date_range}"
                {if $.get.start_date == $date->start_date|date:'Y-m-d'} selected {/if}
                data-price="{$date->price_format}"
                data-clear_price="{$date->clear_price}"
                data-old_price="{$date->old_price_format}"
                data-start_date="{$date->start_date|date:'Y-m-d'}"
                data-discount="{$date->discount}">
                {$date->date_range}
                {$date->status == 'closed' ? ' SOLD OUT' : ''}
        </option>
    {/foreach}
</select>
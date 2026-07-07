<select name="tour_date" class="changePrice fw-bold form-control form-select rounded-pill border-0 w-auto mx-auto pe-5 mb-4" style="background-color:#fff;color:#212529;padding-top:0.75rem;padding-bottom:0.75rem;padding-left:15px;padding-right:15px;">
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
<div class="d-flex gap-3">
    <div class="col">
        <label for="priceRangeMin" class="form-label">From</label>
        <input type="number" class="form-control" id="priceRangeMin" name="price[min]" min="{$min}" max="{$max}" step="0.01" value="{$min}">
    </div>
    <div class="col">
        <label for="priceRangeMax" class="form-label">To</label>
        <input type="number" class="form-control" id="priceRangeMax" name="price[max]" min="{$min}" max="{$max}" step="0.01" value="{$max}">
    </div>
</div>
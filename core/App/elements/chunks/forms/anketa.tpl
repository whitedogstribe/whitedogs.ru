{set $tours = tours()}
<form action="form/anketa" pb-form method="post" class="row row-gap-4 mb-3">
    {csrf}
    {spam}

    {if $.get.tour_id}
        {set $requestTour = model('Tour')->with(['dates', 'image', 'nearestDate'])->where('id', $.get.tour_id)->first()}
    {/if}

    {foreach $fields as $field}
        {switch $field.type}
        {case 'tours'}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-tour" class="form-label">{$field.title}<span class="text-danger">*</span></label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <select name="{$field.name}" class="form-select form-select-lg js-choice" id="anketa-tour"
                        pb-get="/api/tour/{ignore}{value}{/ignore}/dates"
                        pb-trigger="change"
                        pb-target="#anketa-tourdate"
                        pb-swap="innerHTML"
                >
                    {foreach $tours as $tour}
                        <option value="{$tour.id}"{$tour.id == $.get.tour_id ? ' selected': ''}>{$tour.title}</option>
                    {/foreach}
                </select>
            </div>
        {case 'tour_date'}
            <div class="d-flex flex-column col-12 col-md-6">
                <label for="anketa-tourdate" class="form-label">{$field.title}<span class="text-danger">*</span></label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <select class="form-select form-select-lg" id="anketa-tourdate" name="{$field.name}">

                    {if $.get.tour_id}
                        {foreach $requestTour->dates as $date}
                            <option value="{$date->date_range}"{if ($date->start_date|date:'Y-m-d') == $.get.start_date} selected {/if}data-price="{$date->price_format}">{$date->date_range} ({$date->price_format})</option>
                        {/foreach}
                    {else}
                        {foreach $tours[0]->dates as $date}
                            <option value="{$date->date_range}" data-price="{$date->price_format}">{$date->date_range} ({$date->price_format}$){if $date->status == 'closed'} SOLD OUT{/if}</option>
                        {/foreach}
                    {/if}
                </select>
            </div>
        {case 'date'}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-{$field.name}" class="form-label">{$field.title}{if $field.required}<span class="text-danger">*</span>{/if}</label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <input type="hidden" name="{$field.name}" placeholder="{$field.placeholder}">
                <div class="d-flex gap-2">
                    <div class="col">
                        <select name="{$field.name}-day" class="form-select form-select-lg" required>
                            <option disabled selected>Число</option>
                            {foreach 1..31 as $day}
                                <option value="{$day}">{$day}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col">
                        <select name="{$field.name}-month" class="form-select form-select-lg" required>
                            <option disabled selected>Месяц</option>
                            <option value="01">Январь</option>
                            <option value="02">Февраль</option>
                            <option value="03">Март</option>
                            <option value="04">Апрель</option>
                            <option value="05">Май</option>
                            <option value="06">Июнь</option>
                            <option value="07">Июль</option>
                            <option value="08">Август</option>
                            <option value="09">Сентябрь</option>
                            <option value="10">Октябрь</option>
                            <option value="11">Ноябрь</option>
                            <option value="12">Декабрь</option>
                        </select>
                    </div>
                    <div class="col">
                        <input type="number" name="{$field.name}-year" class="form-control" min="1925" max="{date('', 'Y') - 18}" required>
                    </div>
                </div>
                <span class="error" data-error="{$field.name}"></span>
            </div>
        {case 'phone'}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-{$field.name}" class="form-label">{$field.title}{if $field.required}<span class="text-danger">*</span>{/if}</label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <input type="tel" name="{$field.name}" id="anketa-{$field.name}" class="form-control mt-auto" placeholder="{$field.placeholder}" autocomplete="tel">
                <span class="error" data-error="{$field.name}"></span>
            </div>
        {case 'number'}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-{$field.name}" class="form-label">{$field.title}{if $field.required}<span class="text-danger">*</span>{/if}</label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <input type="number" name="{$field.name}" id="anketa-{$field.name}" class="form-control mt-auto" placeholder="{$field.placeholder}">
                <span class="error" data-error="{$field.name}"></span>
            </div>
        {case 'email'}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-{$field.name}" class="form-label">{$field.title}{if $field.required}<span class="text-danger">*</span>{/if}</label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}
                <input type="email" name="{$field.name}" id="anketa-{$field.name}" class="form-control mt-auto" placeholder="{$field.placeholder}">
                <span class="error" data-error="{$field.name}"></span>
            </div>
        {default}
            <div class="d-flex flex-column col-12{if $field['half-field']} col-md-6{/if}">
                <label for="anketa-{$field.name}" class="form-label">{$field.title}{if $field.required}<span class="text-danger">*</span>{/if}</label>
                {if $field.subtitle}
                    <small class="d-block text-muted mb-1">{$field.subtitle}</small>
                {/if}

                {set $key = $field.name}
                {if $key == 'fullname'}
                    {set $key = 'name'}
                {/if}
                <input type="text" name="{$field.name}" id="anketa-{$field.name}" value="{$.get[$key] ?: ''}" class="form-control mt-auto" placeholder="{$field.placeholder}">
                <span class="error" data-error="{$field.name}"></span>
            </div>
        {/switch}
    {/foreach}

    <div class="col-12">
        {$content}

        <button type="submit" class="btn btn-lg btn-success">Отправить анкету</button>
    </div>

</form>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('anketa-tour').addEventListener('change', (event) => {
            let el = event.target;
        })

        const birthdate = document.getElementById('anketa-birthdate');
        if (birthdate && typeof flatpickr == 'function') {

            const maxDate = new Date();
            maxDate.setFullYear(maxDate.getFullYear() - 18);

            flatpickr("#anketa-birthdate", {
                maxDate: maxDate,
                dateFormat: "d-m-Y",
                locale: "ru",
            });
        }
    });

</script>
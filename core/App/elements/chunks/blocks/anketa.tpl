{set $img = $img|fromJSON}
<section class="anketa-form py-4">
    <div class="container">
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="fw-bold">{$title}</h2>
                {if $subtitle}
                    <i class="text-muted">{$subtitle}</i>
                {/if}
            </div>
        </div>
        {insert 'file:chunks/forms/anketa.tpl'}
    </div>
</section>
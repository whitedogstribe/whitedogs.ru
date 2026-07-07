{set $cta = query('pb_block_data')->select('data')->where('id', 761)->value('data')|fromJSON}
<section class="cta-section pt-4 pb-5" id="booking">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-6 mx-auto text-center mb-5">
                <h2 class="h1 font-cofo text-uppercase mb-3">{$cta.title}</h2>
                {if $cta.description}
                    <p>{$cta.description}</p>
                {/if}
            </div>
        </div>
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                {insert 'file:chunks/forms/tour.tpl'}
            </div>
        </div>
    </div>
</section>
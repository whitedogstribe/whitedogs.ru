<section class="faq-section pt-4 pb-3 pb-mb-5" id="faq">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">FAQ</h2>
                {if $modx->resource->faq_title}
                    <h3 class="header-subtitle h5 fw-normal">{$modx->resource->faq_title}</h3>
                {else}
                    <h3 class="header-subtitle h5 fw-normal">Часто задаваемые вопросы про {$modx->resource->menutitle ?: $modx->resource->title}</h3>
                {/if}
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="accordion mx-auto" id="accordionFAQ" style="max-width: 900px">
                    {foreach $modx->resource->faq as $idx => $item}
                        {set $item = $item['data']}
                        <div class="accordion-item">
                            <h4 class="h2 accordion-header">
                                <button class="accordion-button px-0 collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#faq-{$idx}" aria-expanded="false" aria-controls="faq-{$idx}">
                                    {$item.title}
                                </button>
                            </h4>
                            <div id="faq-{$idx}" class="accordion-collapse collapse">
                                <div class="accordion-body text-editor px-0">
                                    {$item.content|faqParser}
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    <style>
        .accordion-item {
            border: none;
        }
        .accordion-header:hover .accordion-button {
            color: var(--color-success);
        }
        .accordion-button {
            font-size: 1.25rem;
        }
        .accordion-button:focus {
            box-shadow: none;
        }
        .accordion-button:not(.collapsed) {
            background: transparent;
        }
        .accordion-body {
            padding: 0;
        }
        .accordion-collapse.show .accordion-body {
            border-bottom: 1px solid #ccc;
        }
    </style>
</section>
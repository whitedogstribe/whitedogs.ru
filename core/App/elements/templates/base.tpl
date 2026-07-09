{block 'placeholders'}{/block}

<!doctype html>
<html lang="{'cultureKey'|config}">
<head>
    {insert 'file:chunks/head.tpl'}

    {block 'seo'}
        <title>{($modx->resource->seo_title ?: $modx->resource->title ?: $modx->resource->pagetitle)|renderPlaceholder} / {'site_name'|config}</title>
        <meta name="description" content="{($modx->resource->seo_desc ?: $modx->resource->description)|renderPlaceholder|notags|ellipsis: 255}">
        {insert 'file:chunks/seo/og.tpl'}
    {/block}

    {block 'schema'}
        {set $seoFile = $modx->getOption('pageblocks_elements_path') ~ 'chunks/seo/' ~ $modx->resource->alias ~ '.tpl'}
        {if file_exists($seoFile)}
            {include ('file:chunks/seo/' ~ $modx->resource->alias ~ '.tpl')}
        {/if}
    {/block}

    {insert 'file:chunks/style.tpl'}
    {block 'style'}{/block}

{*    {insert 'file:chunks/countries.tpl'}*}
</head>
<body class="template-{$modx->resource->template_name ?: 'base'} body-{$modx->resource->alias}">
    <div class="overlay" id="overlay"></div>

    {block 'header'}
        {insert 'file:chunks/header.tpl'}
    {/block}

    {block 'beforeBlocks'}{/block}

    {block 'blocks'}
        {foreach $modx->resource->blocks as $block}
            {$block->render()}
        {/foreach}
    {/block}

    {block 'afterBlocks'}{/block}

    {block 'content'}
        {if $modx->resource->content}
            <section class="section-content{if $modx->resource->template == 2} mt-5 py-5{/if}">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            {if $modx->resource->template == 2}
                                <h1 class="font-cofo text-uppercase">{$modx->resource->pagetitle}</h1>
                            {/if}
                            {$modx->resource->content}
                        </div>
                    </div>
                </div>
            </section>
            <style>
                .section-content h2 {
                    font-family: CoFo, sans-serif;
                }
                .section-content h5 {
                    margin-bottom: 1rem;
                }
                .section-content ul {
                    line-height: 2;
                }
            </style>
        {/if}
    {/block}

    {block 'footer'}
        {insert 'file:chunks/footer.tpl'}
    {/block}

    {insert 'file:chunks/modals/cart.tpl'}
    {insert 'file:chunks/modals/search.tpl'}
    {insert 'file:chunks/modals/signup.tpl'}
    {insert 'file:chunks/modals/order.tpl'}

    {block 'modal'}{/block}

    {block 'telegram'}
        <script src="//code.jivosite.com/widget/X8vLAP3Qqo" async></script>
    {/block}

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            new pbPagination({
                total: {$total ?: 0},
                last_page: {$last_page ?: 1}
            });
        })
    </script>

    {block 'script'}{/block}

</body>
</html>
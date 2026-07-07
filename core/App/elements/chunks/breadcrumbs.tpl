<nav aria-label="breadcrumb" class="mb-2">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/" class="breadcrumb-link"><i class="bi bi-house-door"></i></a></li>
        {foreach $crumbs as $crumb}
            {if $crumb.url}
                <li class="breadcrumb-item"><a href="{$crumb.url}" class="breadcrumb-link">{$crumb.title}</a></li>
            {else}
                <li class="breadcrumb-item active" aria-current="page">{$crumb.title}</li>
            {/if}
        {/foreach}
    </ol>
</nav>
<style>.breadcrumb-link { color: var(--color-success) !important; }</style>

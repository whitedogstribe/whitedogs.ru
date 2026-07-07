<header class="header position-fixed top-0 w-100 {$modx->resource->link_attributes}">
    <nav class="navbar navbar-expand-lg">
        <div class="container position-relative d-flex align-items-center">

            <div class="d-flex d-lg-none align-items-center gap-2 order-1">
                <button type="button" name="cartIcon" class="cartIcon btn position-relative p-0" style="display: none;">
                    <span class="cart-count" pd-cart-count="">0</span>
                    <svg viewBox="0 0 16 16" width="1.2em" height="1.2em"><g fill="currentColor"><path d="M4.04 7.43a4 4 0 0 1 7.92 0a.5.5 0 1 1-.99.14a3 3 0 0 0-5.94 0a.5.5 0 1 1-.99-.14"></path><path fill-rule="evenodd" d="M4 9.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zm1 .5v3h6v-3h-1v.5a.5.5 0 0 1-1 0V10z"></path><path d="M6 2.341V2a2 2 0 1 1 4 0v.341c2.33.824 4 3.047 4 5.659v1.191l1.17.585a1.5 1.5 0 0 1 .83 1.342V13.5a1.5 1.5 0 0 1-1.5 1.5h-1c-.456.607-1.182 1-2 1h-7a2.5 2.5 0 0 1-2-1h-1A1.5 1.5 0 0 1 0 13.5v-2.382a1.5 1.5 0 0 1 .83-1.342L2 9.191V8a6 6 0 0 1 4-5.659M7 2v.083a6 6 0 0 1 2 0V2a1 1 0 0 0-2 0M3 13.5A1.5 1.5 0 0 0 4.5 15h7a1.5 1.5 0 0 0 1.5-1.5V8A5 5 0 0 0 3 8zm-1-3.19l-.724.362a.5.5 0 0 0-.276.447V13.5a.5.5 0 0 0 .5.5H2zm12 0V14h.5a.5.5 0 0 0 .5-.5v-2.382a.5.5 0 0 0-.276-.447L14 10.309Z"></path></g></svg>
                </button>
                <button type="button" name="search" data-bs-toggle="modal" data-bs-target="#searchModal" class="btn px-0">
                    <i class="bi bi-search"></i>
                </button>
            </div>

            <a class="navbar-brand d-flex gap-2 align-items-center p-0 m-0 order-2 order-lg-1" href="/">
                <img src="/assets/images/logo{$modx->resource->link_attributes|replace:'header':''}.svg" width="33" height="28" alt="{$modx->config.site_name}">
                {if $modx->resource->template_name != 'tour-page'}
                    <small class="fw-bold d-none d-xl-block">{$modx->config.site_name}</small>
                {/if}
            </a>

            <button class="header-toggler d-lg-none order-3 btn px-0 ms-auto"
                    data-bs-toggle="modal"
                    data-bs-target="#mobileMenu"
                    aria-label="Открыть меню">
                <span class="header-toggler-bar"></span>
                <span class="header-toggler-bar"></span>
                <span class="header-toggler-bar"></span>
            </button>

            <div class="collapse navbar-collapse order-lg-2" id="navbarDesktop">
                <ul class="navbar-nav mx-auto align-items-center" id="navbar-scrollspy">
                    {insert 'file:chunks/layout/menu.tpl'}
                </ul>
                <div class="d-flex align-items-center gap-3 ms-auto">
{*                    <a href="tel:{$modx->config.phone|phone}" class="fw-bold header-phone d-none d-xl-block">{$modx->config.phone}</a>*}
                    <button type="button" class="cartIcon btn position-relative p-0" style="display: none;">
                        <span class="cart-count" pd-cart-count="">0</span>
                        <svg viewBox="0 0 16 16" width="1.2em" height="1.2em"><g fill="currentColor"><path d="M4.04 7.43a4 4 0 0 1 7.92 0a.5.5 0 1 1-.99.14a3 3 0 0 0-5.94 0a.5.5 0 1 1-.99-.14"></path><path fill-rule="evenodd" d="M4 9.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zm1 .5v3h6v-3h-1v.5a.5.5 0 0 1-1 0V10z"></path><path d="M6 2.341V2a2 2 0 1 1 4 0v.341c2.33.824 4 3.047 4 5.659v1.191l1.17.585a1.5 1.5 0 0 1 .83 1.342V13.5a1.5 1.5 0 0 1-1.5 1.5h-1c-.456.607-1.182 1-2 1h-7a2.5 2.5 0 0 1-2-1h-1A1.5 1.5 0 0 1 0 13.5v-2.382a1.5 1.5 0 0 1 .83-1.342L2 9.191V8a6 6 0 0 1 4-5.659M7 2v.083a6 6 0 0 1 2 0V2a1 1 0 0 0-2 0M3 13.5A1.5 1.5 0 0 0 4.5 15h7a1.5 1.5 0 0 0 1.5-1.5V8A5 5 0 0 0 3 8zm-1-3.19l-.724.362a.5.5 0 0 0-.276.447V13.5a.5.5 0 0 0 .5.5H2zm12 0V14h.5a.5.5 0 0 0 .5-.5v-2.382a.5.5 0 0 0-.276-.447L14 10.309Z"></path></g></svg>
                    </button>
                    <button type="button" name="search" data-bs-toggle="modal" data-bs-target="#searchModal" class="btn px-0">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>

        </div>
    </nav>
</header>

<div class="modal fade modal-mobile-menu" id="mobileMenu" tabindex="-1" aria-label="Мобильное меню">
    <div class="modal-dialog m-0">
        <div class="modal-content">

            <div class="modal-header align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <button type="button" class="cartIcon btn position-relative p-0" style="display: none;">
                        <span class="cart-count" pd-cart-count="">0</span>
                        <svg viewBox="0 0 16 16" width="1.2em" height="1.2em"><g fill="currentColor"><path d="M4.04 7.43a4 4 0 0 1 7.92 0a.5.5 0 1 1-.99.14a3 3 0 0 0-5.94 0a.5.5 0 1 1-.99-.14"></path><path fill-rule="evenodd" d="M4 9.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zm1 .5v3h6v-3h-1v.5a.5.5 0 0 1-1 0V10z"></path><path d="M6 2.341V2a2 2 0 1 1 4 0v.341c2.33.824 4 3.047 4 5.659v1.191l1.17.585a1.5 1.5 0 0 1 .83 1.342V13.5a1.5 1.5 0 0 1-1.5 1.5h-1c-.456.607-1.182 1-2 1h-7a2.5 2.5 0 0 1-2-1h-1A1.5 1.5 0 0 1 0 13.5v-2.382a1.5 1.5 0 0 1 .83-1.342L2 9.191V8a6 6 0 0 1 4-5.659M7 2v.083a6 6 0 0 1 2 0V2a1 1 0 0 0-2 0M3 13.5A1.5 1.5 0 0 0 4.5 15h7a1.5 1.5 0 0 0 1.5-1.5V8A5 5 0 0 0 3 8zm-1-3.19l-.724.362a.5.5 0 0 0-.276.447V13.5a.5.5 0 0 0 .5.5H2zm12 0V14h.5a.5.5 0 0 0 .5-.5v-2.382a.5.5 0 0 0-.276-.447L14 10.309Z"></path></g></svg>
                    </button>
                    <button type="button" data-bs-toggle="modal" data-bs-target="#searchModal" class="btn px-0">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                <a class="navbar-brand d-flex gap-2 align-items-center p-0 mx-auto my-0" href="/">
                    <img loading="lazy" src="/assets/images/logo.svg" width="33" height="28" alt="Племя Белых Псов">
                </a>
                <button type="button" class="btn p-0" data-bs-dismiss="modal" aria-label="Закрыть">
                    <i class="bi bi-x" style="font-size: 1.75rem; line-height: 1;"></i>
                </button>
            </div>

            <div class="modal-body">
                <ul class="list-unstyled m-0">
                    {foreach $menu as $item}
                        {if $item.class_key == 'MODX\Revolution\modWebLink'}
                            {if $.get['view'] == 'list'}
                                {set $item.active = 1}
                            {/if}
                            <li class="nav-item">
                                <a class="nav-link{$item.active ? " active": ""}" href="{$item.content}{$item.attributes}" >{$item.title}</a>
                            </li>
                        {else}
                            {if $.get['view'] == 'list'}
                                {set $item.active = 0}
                            {/if}
                            <li class="nav-item">
                                <a class="nav-link{$item.active ? " active": ""}" href="{$item.uri}" {$item.attributes}>{$item.title}</a>
                            </li>
                        {/if}
                    {/foreach}
                </ul>
            </div>

{*            <div class="modal-footer justify-content-start">*}
{*                <a href="tel:{$modx->config.phone|phone}" class="fw-bold fs-5 text-black">*}
{*                    <i class="bi bi-telephone me-2"></i>{$modx->config.phone}*}
{*                </a>*}
{*            </div>*}

        </div>
    </div>
</div>
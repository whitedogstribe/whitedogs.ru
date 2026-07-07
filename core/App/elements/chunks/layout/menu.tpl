{if $modx->resource->template_name == 'tour-page'}
    {set $hash = [
        ['title' => 'Описание', 'link' => 'about'],
        ['title' => 'Программа', 'link' => 'days'],
        ['title' => 'Гиды', 'link' => 'team'],
        ['title' => 'Стоимость', 'link' => 'price'],
        ['title' => 'Отзывы', 'link' => 'reviews'],
        ['title' => 'Снаряга', 'link' => 'equipment'],
        ['title' => 'FAQ', 'link' => 'faq'],
        ['title' => 'Заявка', 'link' => 'booking'],
    ]}

    <li class="nav-item dropdown">
        <button class="nav-link fs-16" type="button" data-bs-toggle="dropdown" aria-expanded="false">
            <svg height="26" width="24" class="mr-4" viewBox="0 0 24 26" stroke="currentColor" stroke-width="2"><path d="m.533 16.773 22.83-7.034M.533 25l22.83-7.035M.533 8.547l22.83-7.035"></path></svg>
            <span class="ps-1">Меню</span>
        </button>
        <ul class="dropdown-menu ps-4" style="left:8px;">
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
    </li>

    {foreach $hash as $item}
        <li class="nav-item">
            <a class="nav-link" href="{$modx->resource->uri}#{$item.link}">{$item.title}</a>
        </li>
    {/foreach}

    <li class="nav-item">
        <a class="nav-link{$modx->resource->alias == 'go' ? " active": ""}" href="{$modx->resource->uri}/go">Страховка</a>
    </li>

{else}
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
{/if}
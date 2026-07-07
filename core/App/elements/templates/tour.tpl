{extends 'file:templates/base.tpl'}

{block 'beforeBlocks'}
    {insert 'file:chunks/blocks/tours.tpl'}
    {insert 'file:chunks/blocks/order.tpl'}
{/block}

{block 'content'}{/block}

{block 'modal'}
    {insert 'file:chunks/modals/filter.tpl'}
{/block}
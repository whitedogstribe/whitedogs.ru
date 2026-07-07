{extends 'file:templates/base.tpl'}

{block 'schema'}
{*    {insert 'file:chunks/seo/people.tpl'}*}
{/block}

{block 'content'}
    {insert 'file:chunks/svg.tpl'}
    {set $title = $modx->resource->pagetitle}
    {insert 'file:chunks/blocks/hero-blur.tpl'}
    {insert 'file:chunks/blocks/team-content.tpl'}
    {insert 'file:chunks/blocks/leads-travels.tpl'}
    {insert 'file:chunks/blocks/leads-posts.tpl'}
{/block}
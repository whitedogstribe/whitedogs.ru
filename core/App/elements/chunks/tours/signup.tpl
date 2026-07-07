{set $block = query('pb_block_data')->select('data')->where('id', 779)->value('data')|fromJSON}
<section class="signup-section bg-light-gray pt-4 pb-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="h1 font-cofo text-uppercase mb-3">{$block.title}</h2>
                <div class="d-block d-md-none">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
            </div>
        </div>
    </div>

    <div class="f-carousel f-carousel-mobile" id="signup-carousel">
        <div class="f-carousel__viewport">
            {foreach $block.items as $idx => $item}
                {set $img = $item.img|fromJSON}
                <div class="signup-col f-carousel__slide">
                    <div class="signup-item">
                        <div class="signup-index">
                            <img loading="lazy" src="{$img.url|glide:'w=200&h=200&fit=crop&fm=webp'}" width="200" height="200" alt="{$item.title}">
                        </div>
                        <div class="text-editor">
                            <small class="d-block fw-bold mb-3">{$item.title}</small>
                            {$item.desc|replace:'<p>':'<p class="fs-14 mb-0">'}
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>

    <style>
        .signup-col {
            flex: 0 0 auto;
            width: 200px;
            padding: 0;
        }
        .signup-item {
            display: flex;
            flex-direction: column;
            gap: .5rem;
        }
        .signup-index {
            position: relative;
            margin-bottom: 25px;
        }
        .signup-index span {
            position: relative;
            left: 15px;
            display: block;
            font-size: 30px;
            line-height: 25px;
            font-weight: bold;
        }
        .signup-item .text-editor {
            padding-left: 40px;
        }

        @media (min-width: 768px) and (max-width: 1399.98px) {
            #signup-carousel .f-carousel__viewport {
                max-width: 740px;
            }
        }
    </style>
</section>
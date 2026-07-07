<section class="benefits pt-4 pb-3 pb-md-5">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-3 mb-md-5 px-4">
                <h2 class="header-title font-cofo text-uppercase mb-3">{$title}</h2>
                <div class="d-block d-md-none">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
            </div>
        </div>

        <div class="cards-wrapper mx-auto">
            <div class="f-carousel f-carousel-mobile" id="plan-carousel">
                <div class="f-carousel__viewport gap-md-3">
                    {foreach $items as $item}
                        {set $img = $item.img|fromJSON}
                        <div class="flip-item f-carousel__slide">
                            <div class="flip-card">
                                <div class="flip-card-inner">
                                    <div class="flip-card-front" style="background-image: url({$img.url|glide:'w=210&h=350&fit=crop&fm=webp'})">
                                        <h5>{$item.title}</h5>
                                    </div>
                                    <div class="flip-card-back">
                                        <h5>{$item.title}</h5>
                                        <small>{$item.description}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    <style>
        .flip-item {
            height: 350px;
            width: 225px;
        }
        .flip-card {
            width: 100%;
            height: 100%;
            perspective: 1000px;
        }
        .flip-card h5 {
            position: relative;
            z-index: 10;
            text-align: center;
            font-weight: 600;
        }
        .flip-card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            transition: transform 0.6s;
            transform-style: preserve-3d;
        }
        .flip-card:hover .flip-card-inner {
            transform: rotateY(180deg);
        }
        .flip-card-front,
        .flip-card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 28px;
            box-sizing: border-box;
            z-index: 2;
        }
        .flip-card-front {
            background-color: #404043;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
            color: white;
        }
        .flip-card-front:before {
            content:'';
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,.3);
            z-index: 1;
            border-radius: 16px;
            display: flex;
        }
        .flip-card-back {
            background: #404043;
            color: white;
            transform: rotateY(180deg);
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            flex-direction: column;
            align-items: flex-start;
            justify-content: flex-start;
            text-align: left;
        }

        @media (max-width: 1462px) {
            .cards-wrapper {
                max-width: 739px;
            }
        }
        @media (max-width: 738.98px) {
            .cards-wrapper {
                max-width: 498px;
            }
        }
    </style>
</section>
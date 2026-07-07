{extends 'file:templates/base.tpl'}

{block 'header'}{/block}

{block 'content'}
<section class="error-page d-flex align-items-center" style="background-image: url(/assets/images/content/404.webp)">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="font-cofo fw-bold">404</h1>
                <h2 class="font-cofo mb-4">Что-то пошло не так</h2>
                <p>Кажется ты зашел туда где еще никто не был!</p>
                <p>Возможно мы удалили эту страницу или перенесли в другое место</p>
                <p>Если она тебе очень нужна напиши нам и мы поможем её найти</p>
                <a href="/" class="btn btn-success btn-lg rounded-5 px-5 mt-4 fw-bold d-inline-block">На главную страницу</a>
            </div>
        </div>
    </div>
    <style>
        .error-page {
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
            height: 100vh;
            width: 100vw;
        }
        .error-page h1 {
            font-size: 8rem;
            line-height: 1;
            opacity: .2;
        }
        .error-page h2 {
            font-size: 1.5rem;
            line-height: 2rem;
        }
        .error-page p {
            margin-bottom: 8px;
        }
    </style>
</section>
{/block}

{block 'footer'}{/block}
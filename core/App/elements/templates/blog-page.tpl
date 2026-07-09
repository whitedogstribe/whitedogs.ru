{extends 'file:templates/base.tpl'}

{block 'schema'}
    {insert 'file:chunks/seo/post.tpl'}
{/block}

{block 'content'}
    ffff
    <section class="blog-section mt-5 py-5">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-7 ms-auto">
                    {set $crumbs=[['title'=>'Блог','url'=>'/blog'],['title'=>$modx->resource->title,'url'=>'']]}
                    {insert 'file:chunks/breadcrumbs.tpl'}
                    <div class="d-flex align-items-center gap-3 mb-4">
                        {if $modx->resource->team->name}
                            {set $avatar = $modx->resource->team->avatar|fromJSON}
                            {set $avatar = $avatar.url}
                        {elseif $modx->resource->user->photo}
                            {set $avatar = $modx->resource->user->photo}
                        {/if}
                        {block 'avatar'}
                        {if $avatar}
                            <img loading="lazy" src="{$avatar|glide:'w=56&h=56&fit=crop&fm=webp'}" class="img-fluid rounded-5" width="56" height="56" style="border: 1px solid #D9D9D9" alt="{$modx->resource->title}">
                        {else}
                            <div style="width: 56px;height: 56px; background: #D9D9D9;border-radius: 50%"></div>
                        {/if}
                        {/block}
                        <div class="d-flex flex-column gap-2">
                            {if $modx->resource->team->name}
                                <a href="{route('team.show', ['alias' => $modx->resource->team->alias])}" class="text-success">{$modx->resource->team->name}</a>
                            {elseif $modx->resource->user->fullname}
                                <small>{$modx->resource->user->fullname}</small>
                            {/if}

                            <div class="d-flex align-items-center gap-3">
                                <small class="d-flex align-items-center gap-1">
                                    <i class="bi bi-calendar3" style="font-size:13px"></i>
                                    {$modx->resource->publishedAtRu()}
                                </small>
                                <small class="d-flex align-items-center gap-1">
                                    <i class="bi bi-eye" style="font-size:13px"></i>
                                    {$modx->resource->views}
                                </small>
                            </div>
                        </div>
                    </div>
                    <h1 class="font-cofo">{$modx->resource->title}</h1>

                    {$modx->resource->description}

                    {if $modx->resource->video}
                        {set $video = $modx->resource->video|fromJSON}
                        {if $video.provider == 'youtube'}
                            <iframe src="{$video.embed_video}" class="mt-4" frameborder="0" width="100%"></iframe>
                        {/if}
                    {else}
                        {set $img = $modx->resource->img|fromJSON}
                        <img loading="lazy" src="{$img.url|glide:'w=746&h=560&fit=crop&fm=webp'}" width="746" height="560" class="img-fluid rounded-4 my-4" alt="{$modx->resource->title}">
                    {/if}


                    <div class="blog-content">
                        {if $modx->resource->old_content}
                            {$modx->resource->old_content|render}
                        {else}
                            {$modx->resource->content|editorjs|replace:'<p>&nbsp;</p>':''}
                        {/if}
                    </div>
                    <hr>
                    <div class="d-flex align-items-center gap-3 mb-4">
                        <div class="d-flex align-items-center gap-2">
                            {paste 'avatar'}
                            {if $modx->resource->team->name}
                                <a href="{route('team.show', ['alias' => $modx->resource->team->alias])}" class="text-success">{$modx->resource->team->name}</a>
                            {elseif $modx->resource->user->fullname}
                                <small>{$modx->resource->user->fullname}</small>
                            {/if}
                        </div>
                        <div class="d-flex align-items-center gap-3 ms-auto">
                            <small class="d-flex align-items-center gap-1">
                                <i class="bi bi-calendar3" style="font-size:13px"></i>
                                {$modx->resource->publishedAtRu()}
                            </small>
                            <small class="d-flex align-items-center gap-1">
                                <i class="bi bi-eye" style="font-size:13px"></i>
                                {$modx->resource->views}
                            </small>
                        </div>
                    </div>

                    {insert 'file:chunks/blogs/adjacent.tpl'}

                </div>
                <div class="d-flex flex-column gap-5 col-12 col-lg-4 ps-lg-5">
                    {insert 'file:chunks/blogs/popular.tpl'}
                    
                    
                   <div class="mobile-social" id="mobileSocial">
                   
                       <div class="ms-items">
                   
                           <a href="https://t.me/whitedogstribechannel" target="_blank" class="ms-btn-full tg">
                               <svg viewBox="0 0 24 24">
                                   <path d="M9.99 15.58l-.4 5.64c.57 0 .82-.25 1.12-.55l2.7-2.6 5.6 4.1c1.03.57 1.76.27 2.04-.95l3.7-17.3c.37-1.67-.6-2.32-1.6-1.95L1.4 9.4c-1.6.62-1.58 1.52-.27 1.92l5.6 1.75L19.6 5.3c.62-.38 1.2-.17.73.21"/>
                               </svg>
                               <span>Телеграм канал</span>
                           </a>
                   
                           <a href="https://vk.com/whitedogstribe" target="_blank" class="ms-btn-full vk">
                               <svg viewBox="0 0 24 24">
                                   <path d="M12.785 16.241s.362-.04.547-.237c.17-.18.164-.518.164-.518s-.023-1.58.713-1.812c.726-.227 1.656 1.527 2.645 2.204.748.513 1.316.401 1.316.401l2.645-.037s1.383-.085.727-1.176c-.054-.09-.384-.806-1.975-2.282-1.664-1.544-1.441-1.295.563-3.963 1.222-1.626 1.71-2.619 1.557-3.045-.146-.406-1.05-.298-1.05-.298l-2.978.018s-.221-.03-.385.068c-.16.095-.262.317-.262.317s-.472 1.258-1.102 2.327c-1.328 2.253-1.859 2.372-2.076 2.232-.503-.324-.377-1.3-.377-1.995 0-2.168.329-3.073-.641-3.308-.322-.078-.56-.13-1.384-.138-1.057-.011-1.951.003-2.458.248-.338.163-.599.525-.439.546.197.026.643.12.879.444.305.418.294 1.356.294 1.356s.176 2.551-.41 2.87c-.402.22-.954-.229-2.139-2.273-.606-1.045-1.063-2.2-1.063-2.2s-.088-.216-.246-.332c-.192-.14-.46-.184-.46-.184l-2.831.018s-.425.012-.58.197c-.138.165-.011.507-.011.507s2.216 5.182 4.727 7.793c2.303 2.395 4.917 2.238 4.917 2.238z"/>
                               </svg>
                               <span>Паблик ВК</span>
                           </a>
                   
                           <a href="https://www.instagram.com/whitedogstribe" target="_blank" rel="nofollow" class="ms-btn-full ig">
                           
                               <svg viewBox="0 0 24 24">
                                   <path d="M7 2C4.24 2 2 4.24 2 7v10c0 2.76 2.24 5 5 5h10c2.76 0 5-2.24 5-5V7c0-2.76-2.24-5-5-5H7zm10 2c1.65 0 3 1.35 3 3v10c0 1.65-1.35 3-3 3H7c-1.65 0-3-1.35-3-3V7c0-1.65 1.35-3 3-3h10zm-5 3a5 5 0 100 10 5 5 0 000-10zm0 2a3 3 0 110 6 3 3 0 010-6zm4.5-2.75a1.25 1.25 0 100 2.5 1.25 1.25 0 000-2.5z"/>
                               </svg>
                           
                               <span>Instagram</span>
                           
                           </a>
                   
                           <a href="https://www.youtube.com/channel/UCG8E0npo_jeGMNPEZYnOr-A" target="_blank" class="ms-btn-full yt">
                               <svg viewBox="0 0 24 24">
                                   <path d="M23.5 6.2a3 3 0 00-2.1-2.1C19.7 3.5 12 3.5 12 3.5s-7.7 0-9.4.6A3 3 0 00.5 6.2 31.6 31.6 0 000 12a31.6 31.6 0 00.5 5.8 3 3 0 002.1 2.1c1.7.6 9.4.6 9.4.6s7.7 0 9.4-.6a3 3 0 002.1-2.1A31.6 31.6 0 0024 12a31.6 31.6 0 00-.5-5.8zM9.6 15.5v-7l6.2 3.5-6.2 3.5z"/>
                               </svg>
                               <span>YouTube</span>
                           </a>
                   
                       </div>
                   
                       <button class="ms-main" id="msToggle">
                           Подписаться
                       </button>
                   
                   </div>
                    
                    <div class="sticky-social">
                        
                        {insert 'file:chunks/tours/recommend.tpl'}
                        
                        <div class="cta-subscribe mt-4">
                        
                            <div class="cta-content">
                                <h5>🔥 Не пропусти новые походы</h5>
                                <p>Публикуем маршруты, даты и полезные советы в Telegram</p>
                        
                                <a href="https://t.me/whitedogstribechannel" target="_blank" rel="nofollow" class="cta-btn">
                                    Подписаться в Telegram
                                </a>
                            </div>
                        
                            <div class="cta-socials">
                        
                                <a href="https://www.instagram.com/whitedogstribe" target="_blank" rel="nofollow" class="cta-icon ig">
                                    <!-- instagram -->
                                    <svg viewBox="0 0 24 24" width="20" height="20">
                                           <path d="M7 2C4.24 2 2 4.24 2 7v10c0 2.76 2.24 5 5 5h10c2.76 0 5-2.24 5-5V7c0-2.76-2.24-5-5-5H7zm10 2c1.65 0 3 1.35 3 3v10c0 1.65-1.35 3-3 3H7c-1.65 0-3-1.35-3-3V7c0-1.65 1.35-3 3-3h10zm-5 3a5 5 0 100 10 5 5 0 000-10zm0 2a3 3 0 110 6 3 3 0 010-6zm4.5-2.75a1.25 1.25 0 100 2.5 1.25 1.25 0 000-2.5z"/>
                                    </svg>
                                </a>
                        
                                <a href="https://vk.com/whitedogstribe" target="_blank" rel="nofollow" class="cta-icon vk">
                                    <!-- vk -->
                                    <svg viewBox="0 0 24 24" width="20" height="20">
                                           <path d="M12.785 16.241s.362-.04.547-.237c.17-.18.164-.518.164-.518s-.023-1.58.713-1.812c.726-.227 1.656 1.527 2.645 2.204.748.513 1.316.401 1.316.401l2.645-.037s1.383-.085.727-1.176c-.054-.09-.384-.806-1.975-2.282-1.664-1.544-1.441-1.295.563-3.963 1.222-1.626 1.71-2.619 1.557-3.045-.146-.406-1.05-.298-1.05-.298l-2.978.018s-.221-.03-.385.068c-.16.095-.262.317-.262.317s-.472 1.258-1.102 2.327c-1.328 2.253-1.859 2.372-2.076 2.232-.503-.324-.377-1.3-.377-1.995 0-2.168.329-3.073-.641-3.308-.322-.078-.56-.13-1.384-.138-1.057-.011-1.951.003-2.458.248-.338.163-.599.525-.439.546.197.026.643.12.879.444.305.418.294 1.356.294 1.356s.176 2.551-.41 2.87c-.402.22-.954-.229-2.139-2.273-.606-1.045-1.063-2.2-1.063-2.2s-.088-.216-.246-.332c-.192-.14-.46-.184-.46-.184l-2.831.018s-.425.012-.58.197c-.138.165-.011.507-.011.507s2.216 5.182 4.727 7.793c2.303 2.395 4.917 2.238 4.917 2.238z"/>
                                    </svg>
                                </a>
                        
                        
                                <a href="https://www.youtube.com/channel/UCG8E0npo_jeGMNPEZYnOr-A" target="_blank" rel="nofollow" class="cta-icon yt">
                                    <!-- yt -->
                                    <svg viewBox="0 0 24 24" width="20" height="20">
                                           <path d="M23.5 6.2a3 3 0 00-2.1-2.1C19.7 3.5 12 3.5 12 3.5s-7.7 0-9.4.6A3 3 0 00.5 6.2 31.6 31.6 0 000 12a31.6 31.6 0 00.5 5.8 3 3 0 002.1 2.1c1.7.6 9.4.6 9.4.6s7.7 0 9.4-.6a3 3 0 002.1-2.1A31.6 31.6 0 0024 12a31.6 31.6 0 00-.5-5.8zM9.6 15.5v-7l6.2 3.5-6.2 3.5z"/>
                                    </svg>
                                </a>
                        
                            </div>
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <style>
    
        .mobile-social {
          position: fixed;
          left: 15px;
          bottom: 15px;
          z-index: 9999;
        }
        
        
        .ms-items {
          position: absolute;
          bottom: 70px;
          left: 0;   /* вместо right: 0 */
          right: auto;
        
          display: flex;
          flex-direction: column;
          gap: 10px;
        
          opacity: 0;
          pointer-events: none;
          transform: translateY(10px);
          transition: 0.25s;
        }
        
        .ms-btn-full {
          justify-content: flex-start;
        }
        
        .mobile-social.active .ms-items {
          opacity: 1;
          pointer-events: auto;
          transform: translateY(0);
        }
        
        /* КНОПКИ */
        .ms-btn-full {
          display: flex;
          align-items: center;
          gap: 10px;
        
          width: max-content;
          min-width: 220px;
        
          padding: 10px 14px;
          border-radius: 12px;
        
          color: #fff;
          text-decoration: none;
        
          font-size: 13px;
          font-weight: 500;
        
          box-shadow: 0 6px 16px rgba(0,0,0,0.12);
          transition: 0.2s;
        }
        
        .ms-btn-full svg {
          width: 18px;
          height: 18px;
          fill: #fff;
        }
        
        .ms-btn-full:hover {
          transform: translateX(-4px);
        }
        
        /* цвета как у тебя */
        .ms-btn-full.tg { background: #229ED9; }
        .ms-btn-full.vk { background: #4C75A3; }
        .ms-btn-full.ig {
          background: radial-gradient(circle at 30% 30%, #fdf497, #fd5949, #d6249f, #285AEB);
        }
        .ms-btn-full.yt { background: #FF0000; }
        
        /* CTA кнопка */
        .ms-main {
          width: auto;
          height: 56px;
          padding: 0 18px;
        
          border-radius: 28px;
        
          background: #229ED9; /* Telegram */
          color: #fff;
          border: none;
        
          font-size: 14px;
          font-weight: 500;
        
          display: flex;
          align-items: center;
          justify-content: center;
        
          box-shadow: 0 8px 20px rgba(34, 158, 217, 0.35);
          transition: 0.2s ease;
        }
        .ms-main:hover {
          transform: translateY(-2px);
          box-shadow: 0 12px 26px rgba(34, 158, 217, 0.45);
        }
    
        .cta-subscribe {
          background: linear-gradient(135deg, #ffffff, #f5f7fb);
          border-radius: 16px;
          padding: 20px;
          box-shadow: 0 8px 24px rgba(0,0,0,0.06);
          transition: 0.3s;
        }
        
        .cta-subscribe:hover {
          transform: translateY(-3px);
        }
        
        .cta-content h5 {
          margin-bottom: 8px;
        }
        
        .cta-content p {
          font-size: 14px;
          color: #666;
          margin-bottom: 15px;
        }
        
        .cta-btn {
          display: inline-block;
          background: #229ED9;
          color: #fff;
          padding: 10px 16px;
          border-radius: 10px;
          text-decoration: none;
          font-weight: 500;
          transition: 0.25s;
        }
        
        .cta-btn:hover {
          background: #1b8ac2;
        }
        
        /* соцсети */
        .cta-socials {
          display: flex;
          gap: 10px;
          margin-top: 15px;
        }
        
        .cta-icon {
          width: 36px;
          height: 36px;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          transition: 0.2s;
        }
        
        .cta-icon svg {
          width: 18px;
          height: 18px;
          fill: #fff;
        }
        
        .cta-icon:hover {
          transform: scale(1.1);
        }
        
        /* цвета */
        .cta-icon.ig { background: radial-gradient(circle at 30% 30%, #fdf497, #fd5949, #d6249f, #285AEB); }
        .cta-icon.vk { background: #4C75A3; }
        .cta-icon.tg { background: #229ED9; }
        .cta-icon.yt { background: #FF0000; }
        
        .sticky-social {
          position: sticky;
          top: 100px; /* отступ от верха (под хедер) */
          z-index: 10;
        }
        
        .table {
            background-size: 10px 100%,10px 100%;
            background-attachment: scroll,scroll;
            background-repeat: no-repeat;
            border-collapse: collapse;
            border-spacing: 0;
            display: block;
            width: 100%;
            max-width: 100%;
            margin-bottom: 1rem;
            background-color: transparent
        }

        .table .thead {
            display: table-header-group
        }

        .table .tr:first-child .th:first-child {
            border-top-left-radius: 12px
        }

        .table .th:first-child {
            text-align: left;
            padding-left: 20px
        }

        .table .th {
            font-size: 13px;
            display: table-cell;
            font-weight: 700;
            color: #fff;
            line-height: 17px;
            padding: 11px 15px 12px;
            background: #d97706
        }

        .table .tr:first-child .th:last-child {
            border-top-right-radius: 12px
        }

        .table .tbody {
            display: table-row-group
        }

        .table .tr {
            text-align: center;
            display: table-row
        }

        .table .tr .td:first-child {
            text-align: left;
            padding-left: 20px;
            border-left: 0
        }

        .table .tr .td {
            font-size: 11px;
            line-height: 14px;
            display: table-cell;
            padding: 18px;
            background: #fafafa
        }

        .table .tr:last-child .td {
            border-bottom: 0
        }

        .table .tr:nth-child(2n) .td {
            background: #fff
        }

        .table .td img {
            margin: auto
        }

        @media (min-width: 992px) {
            .blog-content .col-lg-12 {
                flex:0 0 100%;
                max-width: 100%
            }
            
            .mobile-social {
                display: none;
              }
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px
        }

        .blog-section iframe {
            width: 100%;
            aspect-ratio: 16 / 9;
            border-radius: 16px;
        }

        @media (min-width: 576px) {
            .blog-content .col-sm-4 {
                flex:0 0 33.333333%;
                max-width: 33.333333%
            }

            .blog-content .col-sm-8 {
                flex: 0 0 66.666667%;
                max-width: 66.666667%
            }
        }

        .blog-content .col,.col-1,.col-10,.col-11,.col-12,.col-2,.col-3,.col-4,.col-5,.col-6,.col-7,.col-8,.col-9,.col-auto,.col-lg,.col-lg-1,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9,.col-lg-auto,.col-md,.col-md-1,.col-md-10,.col-md-11,.col-md-12,.col-md-2,.col-md-3,.col-md-4,.col-md-5,.col-md-6,.col-md-7,.col-md-8,.col-md-9,.col-md-auto,.col-sm,.col-sm-1,.col-sm-10,.col-sm-11,.col-sm-12,.col-sm-2,.col-sm-3,.col-sm-4,.col-sm-5,.col-sm-6,.col-sm-7,.col-sm-8,.col-sm-9,.col-sm-auto,.col-xl,.col-xl-1,.col-xl-10,.col-xl-11,.col-xl-12,.col-xl-2,.col-xl-3,.col-xl-4,.col-xl-5,.col-xl-6,.col-xl-7,.col-xl-8,.col-xl-9,.col-xl-auto {
            position: relative;
            min-height: 1px;
            padding-right: 15px;
            padding-left: 15px
        }

        .blog-content .col-xs-12,
        .blog-content .col-lg-12 {
            width: 100%
        }

        .blog-content blockquote {
            font-size: 14px;
            line-height: 21px;
            padding: 14px 20px;
            display: block;
            background: #00000008;
            margin: 10px 0 1rem
        }

        .blog-content h1,.blog-content h2,.blog-content h3,.blog-content h4,.blog-content h5,.blog-content h6,.blog-content p {
            all: revert
        }

        .blog-content *,.blog-content :after,.blog-content :before {
            box-sizing: border-box
        }

        .blog-content h5 {
            font-size: 1.5em;
            line-height: 1;
            margin-bottom: .9em;
            margin-top: 1.95em
        }

        .blog-content h3 {
            font-size: 1.8rem;
            line-height: 1;
            margin-bottom: .65em;
            margin-top: 1.17em
        }

        .blog-content h2 {
            font-size: 2rem;
            line-height: 1
        }

        .blog-content h1:first-child,.blog-content h2:first-child,.blog-content h3:first-child,.blog-content h4:first-child,.blog-content h5:first-child,.blog-content h6:first-child {
            margin-top: 0
        }

        .blog-content h1:last-child,.blog-content h2:last-child,.blog-content h3:last-child,.blog-content h4:last-child,.blog-content h5:last-child,.blog-content h6:last-child {
            margin-bottom: 0
        }

        .blog-content ul {
            margin: 1em 0;
            padding: 0;
            list-style: none;
        }

        .blog-content ul li {
            position: relative;
            padding-left: 1.5em
        }

        .blog-content ul li+li {
            margin-top: .2em
        }

        .blog-content ul li:before {
            content: "";
            width: 7px;
            height: 7px;
            border-radius: 100%;
            background-color: #05966999;
            position: absolute;
            left: .5em;
            top: .5em
        }

        .blog-content em {
            display: inline-block;
            color: #000000a6
        }

        .blog-content figure img,
        .blog-content img {
            border-radius: 6px;
            transition: all ease .4s
        }
        .blog-content img {
            max-width: 100%;
            height: auto;
        }
        .blog-content figure img {
            height: 100%;
            object-fit: cover;
        }

        .blog-content figure {
            display: flex;
            gap: 6px;
            margin-top: 6px;
            margin-bottom: 6px
        }

        .blog-content .figure-group {
            display: flex;
            gap: 0;
            margin-top: 6px;
            margin-bottom: 6px;
        }
        .blog-content .figure-group figure {
            flex: 1;
            min-width: 0;
            margin: 0;
        }
        .blog-content .figure-group figure a {
            display: block;
        }
        .blog-content .figure-group figure img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 0;
        }
        .blog-content .figure-group figure:first-child img { border-radius: 6px 0 0 6px; }
        .blog-content .figure-group figure:last-child img  { border-radius: 0 6px 6px 0; }

        .blog-content .gallery {
            display: flex;
            gap: 0;
            margin-top: 6px;
            margin-bottom: 6px;
        }
        .blog-content .gallery figure {
            flex: 1;
            min-width: 0;
            margin: 0;
        }
        .blog-content .gallery figure a { display: block; }
        .blog-content .gallery figure img { width: 100%; height: 100%; object-fit: cover; border-radius: 0; }
        .blog-content .gallery figure:first-child img { border-radius: 6px 0 0 6px; }
        .blog-content .gallery figure:last-child img  { border-radius: 0 6px 6px 0; }
        .blog-content .gallery figure:only-child img  { border-radius: 6px; }

        .blog-content figure a {
            position: relative
        }

        .blog-content figure a:after {
            position: absolute;
            display: block;
            content: "";
            right: 16px;
            top: 16px;
            width: 24px;
            height: 24px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cg fill='white' fill-rule='evenodd' clip-rule='evenodd'%3E%3Cpath d='M17.141 2.374c-.924-.124-2.1-.124-3.568-.124h-3.321c-1.467 0-2.644 0-3.568.124c-.957.128-1.755.401-2.388 1.032c-.66.658-.931 1.495-1.053 2.504l-.006.05l.003.195q-.319.208-.599.486c-.748.749-1.08 1.698-1.238 2.87c-.153 1.14-.153 2.595-.153 4.433v.545c.001 1.625.013 2.957.153 4c.158 1.172.49 2.121 1.238 2.87c.749.748 1.698 1.08 2.87 1.238c1.14.153 2.595.153 4.433.153h4.112c1.838 0 3.294 0 4.433-.153c1.172-.158 2.121-.49 2.87-1.238c.748-.749 1.08-1.698 1.238-2.87c.153-1.14.153-2.595.153-4.433v-.112c0-1.838 0-3.294-.153-4.433c-.158-1.172-.49-2.121-1.238-2.87a3.7 3.7 0 0 0-.772-.593v-.093l-.005-.045c-.122-1.009-.392-1.846-1.053-2.504c-.633-.63-1.43-.904-2.388-1.032M2.751 14.84c.003 1.475.022 2.58.139 3.45c.135 1.005.389 1.585.812 2.008s1.003.677 2.009.812c1.028.138 2.382.14 4.289.14h4c1.907 0 3.262-.002 4.29-.14c.763-.102 1.281-.273 1.672-.535l-2.687-2.419a2.25 2.25 0 0 0-2.8-.168l-.297.21a2.75 2.75 0 0 1-3.526-.306l-4.29-4.29a1.55 1.55 0 0 0-2.117-.07zm15.527 2.201l2.588 2.33c.106-.296.186-.65.244-1.082c.138-1.027.14-2.382.14-4.289s-.002-3.261-.14-4.29c-.135-1.005-.389-1.585-.812-2.008s-1.003-.677-2.009-.812c-1.027-.138-2.382-.14-4.289-.14h-4c-1.907 0-3.261.002-4.29.14c-1.005.135-1.585.389-2.008.812S3.025 8.705 2.89 9.71c-.109.807-.133 1.816-.138 3.135l.506-.443a3.05 3.05 0 0 1 4.165.139l4.29 4.29a1.25 1.25 0 0 0 1.602.138l.298-.21a3.75 3.75 0 0 1 4.665.281M5.354 4.47c-.24.239-.412.551-.526 1.053q.328-.072.683-.119c1.14-.153 2.595-.153 4.433-.153h4.112c1.838 0 3.294 0 4.433.153q.256.034.5.081c-.115-.48-.285-.782-.518-1.015c-.308-.307-.737-.502-1.529-.608c-.813-.11-1.889-.111-3.424-.111h-3.211c-1.535 0-2.611.002-3.424.11c-.792.107-1.221.302-1.529.609'/%3E%3Cpath d='M17.5 8.25a2.25 2.25 0 1 0 0 4.5a2.25 2.25 0 0 0 0-4.5m0 1.5a.75.75 0 1 0 0 1.5a.75.75 0 0 0 0-1.5'/%3E%3C/g%3E%3C/svg%3E");
            background-repeat: no-repeat;
            transition: all ease-out .1s;
            scale: .8;
            opacity: 0
        }

        .blog-content figure a:hover:after {
            scale: 1;
            opacity: 1;
            transition-duration: .2s
        }

        @media (hover: none) {
            .blog-content figure a:hover:after {
                transition:all ease-out .1s;
                scale: .8;
                opacity: 0
            }
        }

        .blog-content figure a {
            overflow: hidden;
            border-radius: 6px
        }

        .blog-content figure a:hover img {
            scale: 1.04;
            transition: all ease-out .6s
        }

        .blog-content figure a:active img {
            scale: 1.1;
            transition: all ease-out .6s
        }

        .blog-content a {
            color: #07bb94;
            text-decoration: underline
        }

        .blog-content a[href*="shop/"] {
            color: #b45309
        }

        .blog-content a[href*="shop/"]:hover {
            color: #d97706
        }

        .blog-content a:hover {
            text-decoration: none
        }

        .blog-content .action-button {
            display: inline-block;
            position: relative;
            background-color: #07bb94;
            padding: .5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            color: #fff;
            margin: .5rem 0
        }

        .blog-content .action-button:hover {
            background-color: #059a76
        }

        @media (min-width: 1200px) {
            .blog-routes {
                margin:0 -60px
            }
        }
        .blog-routes img {
            height:375px;
            object-fit: cover;
        }
        .blog-routes h4 {
            font-size: 1.2rem;
        }
        .blog-routes h4 span {
            font-size: 60% !important;
            padding-bottom:5px
        }
        .blog-routes > div {
            padding:0 5px;
        }

    </style>
    
    <script>
        // Group consecutive <figure> elements into flex rows
        document.querySelectorAll('.blog-content').forEach(function(content) {
            var nodes = Array.from(content.childNodes);
            function isFigure(n) { return n.nodeName === 'FIGURE'; }
            function isBlank(n) { return n.nodeType === 3 && n.nodeValue.trim() === ''; }
            var i = 0;
            while (i < nodes.length) {
                if (isFigure(nodes[i])) {
                    var group = [nodes[i]];
                    var j = i + 1;
                    while (j < nodes.length) {
                        if (isFigure(nodes[j])) { group.push(nodes[j]); j++; }
                        else if (isBlank(nodes[j])) { j++; }
                        else { break; }
                    }
                    if (group.length > 1) {
                        var wrapper = document.createElement('div');
                        wrapper.className = 'figure-group';
                        group[0].before(wrapper);
                        group.forEach(function(fig) { wrapper.appendChild(fig); });
                    }
                    i = j;
                } else {
                    i++;
                }
            }
        });

        const ms = document.getElementById('mobileSocial');
        const btn = document.getElementById('msToggle');
        
        btn.addEventListener('click', () => {
          ms.classList.toggle('active');
        });
        
    </script>
{/block}
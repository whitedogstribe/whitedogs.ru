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
        <!--<a href="https://t.me/whitedogstribe" target="_blank" class="telegram position-fixed bottom-0 end-0">
            <i class="bi bi-telegram"></i>
        </a>-->
        <div class="contact-widget" id="contactWidget">
            <div class="cw-tooltip" id="cwTooltip">
              Нужна помощь? 💬
            </div>
          <div class="cw-items">
            <a href="https://t.me/whitedogstribe" target="_blank" class="cw-btn tg" title="Telegram">
              <svg viewBox="0 0 24 24"><path d="M9.99 15.58l-.4 5.64c.57 0 .82-.25 1.12-.55l2.7-2.6 5.6 4.1c1.03.57 1.76.27 2.04-.95l3.7-17.3c.37-1.67-.6-2.32-1.6-1.95L1.4 9.4c-1.6.62-1.58 1.52-.27 1.92l5.6 1.75L19.6 5.3c.62-.38 1.2-.17.73.21"/></svg>
            </a>
            
            <a href="https://wa.me/905356602394" target="_blank" class="cw-btn wa" title="WhatsApp">
              <svg viewBox="0 0 24 24"><path d="M20.52 3.48A11.8 11.8 0 0012.03 0C5.38 0 .02 5.36.02 12c0 2.12.55 4.18 1.6 6l-1.7 6.2 6.35-1.66a11.94 11.94 0 005.76 1.47h.01c6.65 0 12.01-5.36 12.01-12 0-3.2-1.25-6.2-3.53-8.53zM12.04 21.4h-.01a9.94 9.94 0 01-5.07-1.4l-.36-.22-3.77.99 1-3.67-.24-.38a9.92 9.92 0 01-1.53-5.28c0-5.5 4.48-9.98 9.99-9.98 2.67 0 5.17 1.04 7.05 2.92a9.9 9.9 0 012.92 7.05c0 5.5-4.49 9.97-9.98 9.97zm5.5-7.44c-.3-.15-1.76-.87-2.03-.97-.27-.1-.47-.15-.67.15s-.77.97-.94 1.17c-.17.2-.34.22-.64.07-.3-.15-1.25-.46-2.38-1.47-.88-.78-1.47-1.74-1.64-2.04-.17-.3-.02-.46.13-.61.13-.13.3-.34.45-.5.15-.17.2-.3.3-.5.1-.2.05-.37-.02-.52-.07-.15-.67-1.6-.92-2.2-.24-.58-.49-.5-.67-.5h-.57c-.2 0-.52.07-.8.37-.27.3-1.05 1.02-1.05 2.5s1.08 2.9 1.23 3.1c.15.2 2.12 3.23 5.13 4.53.72.31 1.28.5 1.72.64.72.23 1.37.2 1.88.12.57-.08 1.76-.72 2.01-1.42.25-.7.25-1.3.17-1.42-.07-.12-.27-.2-.57-.35z"/></svg>
            </a>
            
            <a href="https://vk.me/whitedogstribe" target="_blank" class="cw-btn vk" title="ВКонтакте">
              <svg viewBox="0 0 24 24"><path d="M12.785 16.241s.362-.04.547-.237c.17-.18.164-.518.164-.518s-.023-1.58.713-1.812c.726-.227 1.656 1.527 2.645 2.204.748.513 1.316.401 1.316.401l2.645-.037s1.383-.085.727-1.176c-.054-.09-.384-.806-1.975-2.282-1.664-1.544-1.441-1.295.563-3.963 1.222-1.626 1.71-2.619 1.557-3.045-.146-.406-1.05-.298-1.05-.298l-2.978.018s-.221-.03-.385.068c-.16.095-.262.317-.262.317s-.472 1.258-1.102 2.327c-1.328 2.253-1.859 2.372-2.076 2.232-.503-.324-.377-1.3-.377-1.995 0-2.168.329-3.073-.641-3.308-.322-.078-.56-.13-1.384-.138-1.057-.011-1.951.003-2.458.248-.338.163-.599.525-.439.546.197.026.643.12.879.444.305.418.294 1.356.294 1.356s.176 2.551-.41 2.87c-.402.22-.954-.229-2.139-2.273-.606-1.045-1.063-2.2-1.063-2.2s-.088-.216-.246-.332c-.192-.14-.46-.184-.46-.184l-2.831.018s-.425.012-.58.197c-.138.165-.011.507-.011.507s2.216 5.182 4.727 7.793c2.303 2.395 4.917 2.238 4.917 2.238z"/></svg>
            </a>
            
        
          </div>
        
          <button class="cw-main" id="cwToggle">
            💬
          </button>
        
        </div>
        
        <style>
        .cw-tooltip {
          position: absolute;
          right: 70px;
          bottom: 15px;
        
          background: #111;
          color: #fff;
          padding: 8px 12px;
          border-radius: 12px;
        
          font-size: 13px;
          white-space: nowrap;
        
          opacity: 0;
          transform: translateX(10px);
          transition: 0.3s ease;
        
          box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        
        /* стрелка */
        .cw-tooltip::after {
          content: "";
          position: absolute;
          right: -6px;
          top: 50%;
          transform: translateY(-50%);
          border-width: 6px;
          border-style: solid;
          border-color: transparent transparent transparent #111;
        }
        
        /* показ */
        .contact-widget.show-tooltip .cw-tooltip {
          opacity: 1;
          transform: translateX(0);
          animation: tooltipPulse 1.5s infinite;
        }
        
        @keyframes tooltipPulse {
          0% { transform: translateX(0) scale(1); }
          50% { transform: translateX(0) scale(1.05); }
          100% { transform: translateX(0) scale(1); }
        }
        
        .contact-widget {
          position: fixed;
          right: 20px;
          bottom: 20px;
          z-index: 9999;
        }
        
        /* основная кнопка */
        .cw-main {
          width: 60px;
          height: 60px;
          border-radius: 50%;
          background: #111;
          color: #fff;
          border: none;
          font-size: 22px;
          cursor: pointer;
          position: relative;
          box-shadow: 0 6px 18px rgba(0,0,0,0.25);
        }
        
        /* 🔥 пульс */
        .cw-main::before {
          content: "";
          position: absolute;
          inset: 0;
          border-radius: 50%;
          background: rgba(0,0,0,0.4);
          animation: pulse 1.8s infinite;
          z-index: -1;
        }
        
        @keyframes pulse {
          0% {
            transform: scale(1);
            opacity: 0.6;
          }
          70% {
            transform: scale(1.8);
            opacity: 0;
          }
          100% {
            opacity: 0;
          }
        }
        
        /* список */
        .cw-items {
          display: flex;
          flex-direction: column;
          gap: 10px;
          position: absolute;
          bottom: 75px;
          right: 0;
        
          opacity: 0;
          transform: translateY(10px);
          pointer-events: none;
          transition: 0.25s ease;
        }
        
        .contact-widget.active .cw-items {
          opacity: 1;
          transform: translateY(0);
          pointer-events: auto;
        }
        
        /* кнопки */
        .cw-btn {
          width: 50px;
          height: 50px;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          box-shadow: 0 4px 10px rgba(0,0,0,0.2);
          transition: 0.2s;
          background: #ccc;
        }
        
        .cw-btn svg {
          width: 22px;
          height: 22px;
          fill: #fff;
        }
        
        .cw-btn:hover {
          transform: scale(1.1);
        }
        
        .cw-btn.vk { background: #4C75A3; }
        .cw-btn.wa { background: #25D366; }
        .cw-btn.tg { background: #229ED9; }
        </style>
        
        <script>
          const widget = document.getElementById('contactWidget');
          const toggle = document.getElementById('cwToggle');
        
          // открыть/закрыть по клику
          toggle.addEventListener('click', () => {
            widget.classList.toggle('active');
          });
        
          // закрытие по клику вне
          document.addEventListener('click', (e) => {
            if (!widget.contains(e.target)) {
              widget.classList.remove('active');
            }
          });
        
          // ⏱ автооткрытие через 10 секунд
          setTimeout(() => {
            widget.classList.add('active');
        
            // и авто-закрытие через 4 сек (как у Jivo)
            setTimeout(() => {
              widget.classList.remove('active');
            }, 4000);
        
          }, 10000);
          
          const tooltip = document.getElementById('cwTooltip');
          
          // показать через 5 секунд
          setTimeout(() => {
            widget.classList.add('show-tooltip');
          }, 5000);
          
          // убрать при открытии
          toggle.addEventListener('click', () => {
            widget.classList.remove('show-tooltip');
          });
          
          // убрать при авто-открытии тоже
          setTimeout(() => {
            widget.classList.remove('show-tooltip');
          }, 10000);
        </script>
        
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
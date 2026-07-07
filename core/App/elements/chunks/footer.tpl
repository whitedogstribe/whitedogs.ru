<footer class="footer overflow-hidden text-white py-5">
    <div class="container">
        <div class="row align-items-center mb-5">
            <div class="col-auto">
                <a class="brand d-flex gap-2 align-items-center p-0 m-0" href="/">
                    <img src="/assets/images/logo-white.svg" width="33" height="28" alt="{$modx->config.site_name}">
                    {if $modx->resource->template_name != 'tour-page'}
                        <small class="fw-bold text-white">{$modx->config.site_name}</small>
                    {/if}
                </a>
            </div>
            <div class="col">
                <hr>
            </div>
        </div>

        <div class="row">
            <div class="footer-col-left footer-padding col-12 col-xl-auto">
                <p class="footer-desc mb-5">Это часть, где мы с вами на связи и делимся самым полезным, чтобы хорошие вещи случались чаще и по любви!</p>
                {insert 'file:chunks/forms/footer.tpl'}
            </div>
            <div class="col-1 d-block d-xl-none"></div>
            <div class="col-12 col-xl mt-5 mt-xl-0 ps-xl-5">
                <div class="row">
                    <div class="col-12 col-xl-4 mb-5 footer-xl-padding">
                        <h6 class="mb-4 text-uppercase">Навигация</h6>
                        <ul class="list-unstyled m-0 d-flex flex-wrap flex-xl-column gap-3">
                            {foreach $menu as $item}
                                <li class="nav-item">
                                    <a class="nav-link{$item.active ? " active": ""}" href="{$item.uri}" {$item.attributes}>{$item.title}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="col-12 col-xl-4 mb-5 footer-xl-padding">
                        <h6 class="mb-4 text-uppercase">Документы</h6>
                        <ul class="list-unstyled m-0 d-flex flex-wrap flex-xl-column gap-3">
                            {set $docs = query('site_content')->where([
                            'parent' => 9,
                            'published' => 1
                            ])->get()}
                            {foreach $docs as $item}
                                <li class="nav-item">
                                    <a class="nav-link" href="/{$item->alias}">{$item->menutitle ?: $item->pagetitle}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="col-12 col-xl-4 mb-5 footer-xl-padding">
                        <h6 class="mb-4 text-uppercase">Запись в поход</h6>
                        <ul class="list-unstyled m-0 d-flex flex-wrap flex-xl-column gap-3 contacts-footer">
                        
                            <li>
                                <a href="tel:{$modx->config.phone|phone}" class="contact-item">
                                    <!-- phone -->
                                    <svg viewBox="0 0 24 24"><path d="M6.6 10.8c1.5 2.9 3.7 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1.1-.3 1.2.4 2.5.6 3.9.6.6 0 1 .4 1 1V21c0 .6-.4 1-1 1C10.1 22 2 13.9 2 3c0-.6.4-1 1-1h4.5c.6 0 1 .4 1 1 0 1.4.2 2.7.6 3.9.1.4 0 .8-.3 1.1l-2.2 2.2z"/></svg>
                                    <span>{$modx->config.phone}</span>
                                </a>
                            </li>
                            
                            <li>
                                <a href="https://t.me/{$modx->config.telegram|replace:'@':''}" target="_blank" class="contact-item tg">
                                    <!-- telegram -->
                                    <svg viewBox="0 0 24 24"><path d="M9.99 15.58l-.4 5.64c.57 0 .82-.25 1.12-.55l2.7-2.6 5.6 4.1c1.03.57 1.76.27 2.04-.95l3.7-17.3c.37-1.67-.6-2.32-1.6-1.95L1.4 9.4c-1.6.62-1.58 1.52-.27 1.92l5.6 1.75L19.6 5.3c.62-.38 1.2-.17.73.21"/></svg>
                                    <span>{$modx->config.telegram}</span>
                                </a>
                            </li>
                        
                            <li>
                                <a href="https://wa.me/{$modx->config.whatsapp|phone}" target="_blank" class="contact-item wa">
                                    <!-- whatsapp -->
                                    <svg viewBox="0 0 24 24"><path d="M20.52 3.48A11.8 11.8 0 0012.03 0C5.38 0 .02 5.36.02 12c0 2.12.55 4.18 1.6 6l-1.7 6.2 6.35-1.66a11.94 11.94 0 005.76 1.47h.01c6.65 0 12.01-5.36 12.01-12 0-3.2-1.25-6.2-3.53-8.53z"/></svg>
                                    <span>WhatsApp</span>
                                </a>
                            </li>
                        
                            <li>
                                <a href="mailto:{$modx->config.email}" class="contact-item mail">
                                    <!-- email -->
                                    <svg viewBox="0 0 24 24"><path d="M12 13L2 6.76V18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6.76L12 13zm10-9H2l10 6 10-6z"/></svg>
                                    <span>{$modx->config.email}</span>
                                </a>
                            </li>
                        
                            <li>
                                <a href="https://t.me/{$modx->config.business_telegram|replace:'@':''}" target="_blank" class="contact-item tg">
                                    <!-- telegram -->
                                    <svg viewBox="0 0 24 24"><path d="M9.99 15.58l-.4 5.64c.57 0 .82-.25 1.12-.55l2.7-2.6 5.6 4.1c1.03.57 1.76.27 2.04-.95l3.7-17.3c.37-1.67-.6-2.32-1.6-1.95L1.4 9.4c-1.6.62-1.58 1.52-.27 1.92l5.6 1.75L19.6 5.3c.62-.38 1.2-.17.73.21"/></svg>
                                    <span>Сотрудничество</span>
                                </a>
                            </li>

                            {if $modx->config.work_time}
                                <p>Часы работы:<br>
                                {$modx->config.work_time}</p>
                            {/if}
                        
                        </ul>
                        
                        <h6 class="mb-4 mt-4 text-uppercase">Соц-сети</h6>
                        <ul class="social-footer">
                           {if $modx->config.social_vk}
                           <li class="nav-item">
                               <a class="nav-link-footer vk" target="_blank" href="{$modx->config.social_vk}" title="ВКонтакте">
                                   <svg viewBox="0 0 24 24" width="20" height="20">
                                       <path d="M12.785 16.241s.362-.04.547-.237c.17-.18.164-.518.164-.518s-.023-1.58.713-1.812c.726-.227 1.656 1.527 2.645 2.204.748.513 1.316.401 1.316.401l2.645-.037s1.383-.085.727-1.176c-.054-.09-.384-.806-1.975-2.282-1.664-1.544-1.441-1.295.563-3.963 1.222-1.626 1.71-2.619 1.557-3.045-.146-.406-1.05-.298-1.05-.298l-2.978.018s-.221-.03-.385.068c-.16.095-.262.317-.262.317s-.472 1.258-1.102 2.327c-1.328 2.253-1.859 2.372-2.076 2.232-.503-.324-.377-1.3-.377-1.995 0-2.168.329-3.073-.641-3.308-.322-.078-.56-.13-1.384-.138-1.057-.011-1.951.003-2.458.248-.338.163-.599.525-.439.546.197.026.643.12.879.444.305.418.294 1.356.294 1.356s.176 2.551-.41 2.87c-.402.22-.954-.229-2.139-2.273-.606-1.045-1.063-2.2-1.063-2.2s-.088-.216-.246-.332c-.192-.14-.46-.184-.46-.184l-2.831.018s-.425.012-.58.197c-.138.165-.011.507-.011.507s2.216 5.182 4.727 7.793c2.303 2.395 4.917 2.238 4.917 2.238z"/>
                                   </svg>
                               </a>
                           </li>
                           {/if}
                           
                           {if $modx->config.social_instagram}
                           <li class="nav-item">
                               <a class="nav-link-footer ig" target="_blank" href="{$modx->config.social_instagram}" title="Instagram">
                                   <svg viewBox="0 0 24 24" width="20" height="20">
                                       <path d="M7 2C4.24 2 2 4.24 2 7v10c0 2.76 2.24 5 5 5h10c2.76 0 5-2.24 5-5V7c0-2.76-2.24-5-5-5H7zm10 2c1.65 0 3 1.35 3 3v10c0 1.65-1.35 3-3 3H7c-1.65 0-3-1.35-3-3V7c0-1.65 1.35-3 3-3h10zm-5 3a5 5 0 100 10 5 5 0 000-10zm0 2a3 3 0 110 6 3 3 0 010-6zm4.5-2.75a1.25 1.25 0 100 2.5 1.25 1.25 0 000-2.5z"/>
                                   </svg>
                               </a>
                           </li>
                           {/if}
                           
                           {if $modx->config.social_youtube}
                           <li class="nav-item">
                               <a class="nav-link-footer yt" target="_blank" href="{$modx->config.social_youtube}" title="YouTube">
                                   <svg viewBox="0 0 24 24" width="20" height="20">
                                       <path d="M23.5 6.2a3 3 0 00-2.1-2.1C19.7 3.5 12 3.5 12 3.5s-7.7 0-9.4.6A3 3 0 00.5 6.2 31.6 31.6 0 000 12a31.6 31.6 0 00.5 5.8 3 3 0 002.1 2.1c1.7.6 9.4.6 9.4.6s7.7 0 9.4-.6a3 3 0 002.1-2.1A31.6 31.6 0 0024 12a31.6 31.6 0 00-.5-5.8zM9.6 15.5v-7l6.2 3.5-6.2 3.5z"/>
                                   </svg>
                               </a>
                           </li>
                           {/if}
                           
                           {if $modx->config.social_telegram}
                           <li class="nav-item">
                               <a class="nav-link-footer tg" target="_blank" href="{$modx->config.social_telegram}" title="Telegram">
                                   <svg viewBox="0 0 24 24" width="20" height="20">
                                       <path d="M9.99 15.58l-.4 5.64c.57 0 .82-.25 1.12-.55l2.7-2.6 5.6 4.1c1.03.57 1.76.27 2.04-.95l3.7-17.3c.37-1.67-.6-2.32-1.6-1.95L1.4 9.4c-1.6.62-1.58 1.52-.27 1.92l5.6 1.75L19.6 5.3c.62-.38 1.2-.17.73.21"/>
                                   </svg>
                               </a>
                           </li>
                           {/if}

                           {if $modx->config.social_facebook}
                           <li class="nav-item">
                               <a class="nav-link-footer fb" target="_blank" href="{$modx->config.social_facebook}" title="Facebook">
                                   <svg viewBox="0 0 24 24" width="20" height="20">
                                       <path d="M22 12a10 10 0 10-11.56 9.88v-6.99H7.9V12h2.54V9.8c0-2.5 1.5-3.9 3.77-3.9 1.1 0 2.24.2 2.24.2v2.46h-1.26c-1.24 0-1.63.77-1.63 1.56V12h2.77l-.44 2.89h-2.33v6.99A10 10 0 0022 12z"/>
                                   </svg>
                               </a>
                           </li>
                           {/if}
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-0 mt-xl-5">
            <div class="col-12 footer-padding">
                <h6 class="mb-3 text-uppercase">Путешествия</h6>
                <ul class="list-unstyled m-0 d-flex flex-wrap gap-3">
                    {foreach $countries as $item}
                        <li class="nav-item">
                            <a class="nav-link{($modx->resource->template_name == 'country' && $modx->resource->id == $item->id)? ' active': ''}" href="/countries/{$item->alias}">{$item->name}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-12 footer-padding">
                <hr>
                <div class="d-flex flex-wrap gap-2">
                    <small>©2018 – {date('','Y')}  | {$modx->config.cooperate}</small>
                    <div class="ms-auto">

                    </div>
                </div>
            </div>
        </div>

        {if $modx->user->id == 1}
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <ul class="list-unstyled">
                        <li><small>total time: {((microtime(true) - $modx->startTime)) | round: 4} s</small></li>
                        <li><small>query time: {$modx->queryTime | round: 4} s</small></li>
                        <li><small>queries: {$modx->executedQueries}</small></li>
                        <li><small>memory: {(memory_get_usage() / 1024 / 1024) | round: 2} MB</small></li>
                    </ul>
                </div>
            </div>
        {/if}
    </div>
</footer>

<style>

.contacts-footer li {
  list-style: none;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
  color: inherit;
  transition: 0.2s;
}

.contact-item svg {
  width: 18px;
  height: 18px;
  fill: currentColor;
  opacity: 0.8;
}

.contact-item:hover {
  transform: translateX(5px);
}

/* цвета акцентов */
.contact-item.tg:hover { color: #229ED9; }
.contact-item.wa:hover { color: #25D366; }
.contact-item.mail:hover { color: #EA4335; }

/* обёртка (ul) — делаем горизонтально */
.social-footer {
  display: flex;
  gap: 10px;
  padding: 0;
  margin: 0;
}

.social-footer li {
  list-style: none;
}

/* сами кнопки */
.nav-link-footer {
  display: flex;
  align-items: center;
  justify-content: center;

  width: 40px;
  height: 40px;
  border-radius: 50%;

  color: #fff;
  text-decoration: none;

  transition: 0.25s;
}

/* svg */
.nav-link-footer svg {
  width: 20px;
  height: 20px;
  fill: #fff;
}

/* hover эффект */
.nav-link-footer:hover {
  transform: scale(1.15);
}

/* цвета */
.nav-link-footer.vk { background: #4C75A3; }
.nav-link-footer.ig { background: radial-gradient(circle at 30% 30%, #fdf497, #fd5949, #d6249f, #285AEB); }
.nav-link-footer.yt { background: #FF0000; }
.nav-link-footer.tg { background: #229ED9; }
.nav-link-footer.fb { background: #1877F2; }
</style>
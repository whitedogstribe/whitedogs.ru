<form action="/form/footer" pb-form method="post" class="footer-form pt-4 d-flex flex-column gap-4">
    {csrf}
    {spam}

    <h6 class="px-3 mb-0">Напишите нам. <br>Мы всё расскажем</h6>

    <div class="row g-2 px-3">
        <div class="col-5">
            <input type="text" name="name" class="form-control" placeholder="Как вас зовут?">
        </div>
        <div class="col-7 position-relative">
            <input type="text" name="contact" id="footer-contact" class="form-control" placeholder="@username">
            <div class="d-flex position-absolute top-50 end-0 translate-middle-y pe-3">
                <input type="radio" class="btn-check" name="contactType" value="telegram" data-placeholder="@username" id="footer-contactType-telegram" autocomplete="off" checked>
                <label class="btn btn-sm border-0 p-1" for="footer-contactType-telegram" title="Связь через Telegram">
                    <svg height="1.2em" width="1.2em" class="inline-block h-5 md:h-6 md:w-6 w-5" viewBox="0 0 24 24"><path d="M20.665 3.717l-17.73 6.837c-1.21.486-1.203 1.161-.222 1.462l4.552 1.42l10.532-6.645c.498-.303.953-.14.579.192l-8.533 7.701h-.002l.002.001l-.314 4.692c.46 0 .663-.211.921-.46l2.211-2.15l4.599 3.397c.848.467 1.457.227 1.668-.785l3.019-14.228c.309-1.239-.473-1.8-1.282-1.434z" fill="currentColor"></path></svg>
                </label>

                <input type="radio" class="btn-check" name="contactType" value="whatsapp" data-placeholder="+792155587380" id="footer-contactType-whatsapp" autocomplete="off">
                <label class="btn btn-sm border-0 p-1" for="footer-contactType-whatsapp" title="Связь через Whatsapp">
                    <svg height="1.2em" width="1.2em" class="inline-block h-5 md:h-6 md:w-6 w-5" viewBox="0 0 24 24"><path d="M18.403 5.633A8.919 8.919 0 0 0 12.053 3c-4.948 0-8.976 4.027-8.978 8.977c0 1.582.413 3.126 1.198 4.488L3 21.116l4.759-1.249a8.981 8.981 0 0 0 4.29 1.093h.004c4.947 0 8.975-4.027 8.977-8.977a8.926 8.926 0 0 0-2.627-6.35m-6.35 13.812h-.003a7.446 7.446 0 0 1-3.798-1.041l-.272-.162l-2.824.741l.753-2.753l-.177-.282a7.448 7.448 0 0 1-1.141-3.971c.002-4.114 3.349-7.461 7.465-7.461a7.413 7.413 0 0 1 5.275 2.188a7.42 7.42 0 0 1 2.183 5.279c-.002 4.114-3.349 7.462-7.461 7.462m4.093-5.589c-.225-.113-1.327-.655-1.533-.73c-.205-.075-.354-.112-.504.112s-.58.729-.711.879s-.262.168-.486.056s-.947-.349-1.804-1.113c-.667-.595-1.117-1.329-1.248-1.554s-.014-.346.099-.458c.101-.1.224-.262.336-.393c.112-.131.149-.224.224-.374s.038-.281-.019-.393c-.056-.113-.505-1.217-.692-1.666c-.181-.435-.366-.377-.504-.383a9.65 9.65 0 0 0-.429-.008a.826.826 0 0 0-.599.28c-.206.225-.785.767-.785 1.871s.804 2.171.916 2.321c.112.15 1.582 2.415 3.832 3.387c.536.231.954.369 1.279.473c.537.171 1.026.146 1.413.089c.431-.064 1.327-.542 1.514-1.066c.187-.524.187-.973.131-1.067c-.056-.094-.207-.151-.43-.263" fill="currentColor" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
                </label>

                <input type="radio" class="btn-check" name="contactType" data-placeholder="name@email.com" value="email" id="footer-contactType-email" autocomplete="off">
                <label class="btn btn-sm border-0 p-1" for="footer-contactType-email" title="Связь через Email">
                    <svg height="1.2em" width="1.2em" class="inline-block h-5 md:h-6 md:w-6 w-5" viewBox="0 0 16 16"><path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2l7-4.2V4a1 1 0 0 0-1-1zm13 2.383l-4.708 2.825L15 11.105zm-.034 6.876l-5.64-3.471L8 9.583l-1.326-.795l-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" fill="currentColor"></path></svg>
                </label>
            </div>
        </div>
    </div>

    <button type="submit" class="btn w-100">Оставить заявку ⭢ </button>
</form>
<script>
    document.querySelector('.footer-form').addEventListener('change', e => {
        if (e.target.name === 'contactType') {
            document.getElementById('footer-contact').placeholder = e.target.dataset.placeholder || '';
        }
    });
</script>
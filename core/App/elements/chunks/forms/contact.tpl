<form action="/form/contacts" pb-form method="post" class="form-contact d-flex flex-column gap-3">
    {csrf}
    {spam}
    <h2 class="fw-bold">Остались <br class="d-none d-lg-block">вопросы?</h2>
    <small>Поделитесь своими контактами и мы свяжемся с вами или отправьте сообщение в чате</small>

    <div class="mb-3">
        <input type="text" name="name" class="form-control bg-transparent border-0 border-bottom rounded-0" placeholder="Как вас зовут?">
        <span class="error" data-error="name"></span>
    </div>
    <div class="mb-3">
        <input type="text" name="contact" class="form-control bg-transparent border-0 border-bottom rounded-0" placeholder="Как в вами связяться?">
        <span class="error" data-error="contact"></span>
    </div>

    <div class="form-check">
        <input type="hidden" name="confirm" value="0">
        <input class="form-check-input" type="radio" name="confirm" value="1" id="radioDefault1">
        <label class="form-check-label" for="radioDefault1">
            <small>Соглашаюсь на обработку персональных данных</small>
        </label>
    </div>

    <button type="submit" class="btn btn-lg text-center btn-danger align-self-start">Отправить заявку</button>
</form>
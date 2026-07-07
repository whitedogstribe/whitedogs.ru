<div class="mini-cart" id="miniCart">
    <div class="d-flex gap-2 align-items-center justify-content-between p-3">
        <h6 class="m-0">Мой рюкзак (<span pd-cart-count>0</span>)</h6>
        <button type="button" class="btn btn-link text-black text-decoration-none" id="closeCart">Закрыть</button>
    </div>
    <hr class="m-0">
    <div class="d-flex flex-column p-4 overflow-y-auto" id="cartItems"></div>
    <hr class="m-0">
    <div class="d-flex align-items-center gap-2 mt-auto py-3 px-4 flex-wrap">
        <small class="d-block w-100">Аренда:</small>
        <div class="d-flex gap-2">
            <div class="col d-flex align-items-center gap-1">
                <small class="text-muted">с</small>
                <input type="date" class="form-control form-control-sm" id="rend_date_from">
            </div>
            <div class="col d-flex align-items-center gap-1">
                <small class="text-muted">по</small>
                <input type="date" class="form-control form-control-sm" id="rend_date_to">
            </div>
        </div>
        <div class="d-block w-100">
            <small id="count_date" class="fw-semibold">1</small>
            <small id="name_date">день</small>
        </div>
    </div>
    <div class="d-flex flex-column align-items-start gap-2 p-4 bg-body-tertiary">
        <h6 class="d-flex gap-2 text-center">
            К оплате: <span class="fw-bold">$<span id="totalPrice">0</span></span> + залог: <span class="fw-bold">$<span id="totalDeposit">0</span></span>
        </h6>
        <button type="button"
                data-bs-toggle="modal"
                data-bs-target="#modal-order"
                class="btn btn-success"
        >Оформить заказ</button>
    </div>
</div>

<div class="modal fade" id="addedToCartModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mx-auto" style="max-width: 360px;">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h6 class="modal-title fw-semibold">Товар добавлен в корзину</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="addedPopupItem" class="d-flex align-items-start gap-3"></div>
            </div>
            <div class="modal-footer d-flex flex-wrap justify-content-between border-0 pt-0 gap-2">
                <button class="btn btn-outline-secondary text-center" data-bs-dismiss="modal">Продолжить покупки</button>
                <button class="btn btn-success text-center" id="addedPopupCheckout">Оформить</button>
            </div>
        </div>
    </div>
</div>
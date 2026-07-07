class Cart {
    constructor() {
        const cartData = this.loadCart();
        this.items = cartData.items;
        this.rentalDays = cartData.rentalDays;
        this.init();
    }

    loadCart() {
        const saved = localStorage.getItem('cart');
        if (saved) {
            const data = JSON.parse(saved);
            return {
                items: data.items || {},
                rentalDays: data.rentalDays || 1
            };
        }
        return {
            items: {},
            rentalDays: 1
        };
    }

    saveCart() {
        localStorage.setItem('cart', JSON.stringify({
            items: this.items,
            rentalDays: this.rentalDays
        }));
    }

    async addItem(productId) {
        try {
            const btn = document.querySelector(`[data-product-id="${productId}"]`);
            const originalText = btn.textContent;
            btn.textContent = 'Загрузка...';
            btn.disabled = true;

            pbFetch.ajax({
                url: `/api/products/${productId}`,
                expect: 'json',
                success: (response, data) => {
                    let product = data.product;

                    if (this.items[product.id]) {
                        this.items[product.id].quantity++;
                    } else {
                        this.items[product.id] = { ...product, quantity: 1 };
                    }

                    this.saveCart();
                    this.updateUI();
                    this.showAddedModal(product);

                    btn.disabled = false;
                }

            })


        } catch (error) {
            console.error('Ошибка при добавлении товара:', error);
            alert('Не удалось добавить товар в корзину');

            // Восстанавливаем кнопку
            const btn = document.querySelector(`[data-product-id="${productId}"]`);
            btn.textContent = btn.dataset.text;
            btn.disabled = false;
        }
    }

    removeItem(productId) {
        delete this.items[productId];
        this.saveCart();
        this.updateUI();
    }

    updateQuantity(productId, delta) {
        if (this.items[productId]) {
            this.items[productId].quantity += delta;
            if (this.items[productId].quantity <= 0) {
                this.removeItem(productId);
            } else {
                this.saveCart();
                this.updateUI();
            }
        }
    }

    isInCart(productId) {
        return !!this.items[productId];
    }

    // Получить цену товара в зависимости от количества дней аренды
    getItemPrice(item) {
        // Если товар для продажи (rent = 0), возвращаем обычную цену
        if (!item.rent) {
            return parseFloat(item.price);
        }

        // Товар для аренды
        const days = this.rentalDays;

        // Если 6 и более дней, используем поле price
        if (days >= 6) {
            return parseFloat(item.price);
        }

        // Для 1-5 дней используем rental_prices
        if (item.rental_prices && item.rental_prices.length >= days) {
            const totalPrice = parseFloat(item.rental_prices[days - 1]);
            // Возвращаем цену за день (делим на количество дней)
            return totalPrice / days;
        }

        // Fallback на обычную цену, если rental_prices нет
        return parseFloat(item.price);
    }

    getTotalPrice() {
        return Object.values(this.items).reduce((sum, item) => {
            const pricePerDay = this.getItemPrice(item);
            // Для товаров аренды умножаем на количество дней
            const totalItemPrice = item.rent
                ? pricePerDay * this.rentalDays * item.quantity
                : pricePerDay * item.quantity;
            return sum + totalItemPrice;
        }, 0);
    }

    getTotalDeposit() {
        return Object.values(this.items).reduce((sum, item) => sum + (item.rent ? item.deposit * item.quantity : 0), 0);
    }

    getTotalItems() {
        return Object.values(this.items).reduce((sum, item) => sum + item.quantity, 0);
    }

    updateUI() {
        this.updateCartCount();
        this.updateMiniCart();
        this.updateButtons();
        this.updateCartIconVisibility();
    }

    updateCartCount() {
        let count = this.getTotalItems();
        document.querySelectorAll('[pd-cart-count]').forEach(el => {
            el.textContent = count;
        });
    }

    getCartSummary() {
        const items = Object.values(this.items).map(item => ({
            id: item.id,
            title: item.title,
            quantity: item.quantity,
            pricePerDay: this.getItemPrice(item),
            rent: item.rent,
            deposit: item.deposit || 0
        }));

        return {
            items,
            total: this.getTotalPrice(),
            deposit: this.getTotalDeposit(),
            rentalDays: this.rentalDays
        };
    }

    updateCartIconVisibility() {
        const cartIcons = document.querySelectorAll('.cartIcon');
        if (cartIcons.length) {
            if (this.getTotalItems() > 0) {
                cartIcons.forEach(el => {
                    el.style.display = '';
                })
            } else {
                cartIcons.forEach(el => {
                    el.style.display = 'none';
                })
            }
        }
    }

    updateMiniCart() {
        const cartItemsContainer = document.getElementById('cartItems');
        if (!cartItemsContainer) {
            return;
        }
        const items = Object.values(this.items);

        if (items.length === 0) {
            cartItemsContainer.innerHTML = '<div class="empty-cart"><p>Корзина пуста</p></div>';
        } else {
            cartItemsContainer.innerHTML = items.map((item, index) => {
                const pricePerDay = this.getItemPrice(item);
                const displayPrice = this.formatPrice(pricePerDay);

                return `
                    <div class="d-flex align-items-start gap-2">
                        <img loading="lazy" class="img-fluid rounded-3" src="${item.thumb}" alt="${item.title}" width="60" height="60">
                        
                        <div class="col d-flex flex-column gap-1">
                            <div class="d-flex gap-2 align-items-start">
                                <h6 class="m-0">${item.title}</h6>
                                <button type="button" class="remove-btn" onclick="cart.removeItem(${item.id})">✕</button>
                            </div>
                            
                            <div class="d-flex align-items-center gap-2">
                                <div class="d-flex flex-wrap align-items-center gap-2">
                                    <small class="d-block text-muted w-100">Кол-во:</small>
                                    <button type="button" class="quantity-btn" onclick="cart.updateQuantity(${item.id}, -1)">-</button>
                                    <span>${item.quantity}</span>
                                    <button type="button" class="quantity-btn" onclick="cart.updateQuantity(${item.id}, 1)">+</button>
                                </div>
                                
                                <div class="d-flex flex-wrap gap-2 ms-auto">
                                    <small class="text-muted">${item.rent ? 'Аренда' : 'Цена'}:</small>
                                    <small class="fw-bold">$ ${displayPrice}${item.rent ? ' / день' : ''}</small>
                                </div>
                            </div>
                            
                        </div>
                    </div>${(index < (items.length-1)) ? '<hr>' : ''}
                `;
            }).join('');
        }

        document.getElementById('totalPrice').textContent = `${this.formatPrice(this.getTotalPrice())}`;
        document.getElementById('totalDeposit').textContent = `${this.formatPrice(this.getTotalDeposit())}`;
    }

    updateButtons() {
        const btns = document.querySelectorAll('.add-to-cart-btn');
        btns.forEach(btn => {
            if (this.isInCart(btn.dataset.productId)) {
                btn.textContent = 'В корзине';
                btn.classList.add('in-cart');
            } else {
                btn.textContent = btn.dataset.text;
                btn.classList.remove('in-cart');
            }
        });
    }

    getDaysWord(days) {
        const lastDigit = days % 10;
        const lastTwoDigits = days % 100;

        if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
            return 'дней';
        }

        if (lastDigit === 1) {
            return 'день';
        }

        if (lastDigit >= 2 && lastDigit <= 4) {
            return 'дня';
        }

        return 'дней';
    }

    formatPrice(price) {
        const num = parseFloat(price);
        // Если число целое, возвращаем без десятичных знаков
        if (num % 1 === 0) {
            return num.toString();
        }
        // Иначе возвращаем с десятичными знаками
        return num.toFixed(1);
    }

    init() {
        this.initButton();
        this.initDate();
        this.updateUI();
        this.initEventListeners();
        this.initModalListener();
        this.initAddedModal();
    }

    initButton() {
        document.querySelectorAll('.add-to-cart-btn').forEach(btn => {
            btn.addEventListener('click', async (e) => {
                const productId = parseInt(e.target.dataset.productId);
                if (this.isInCart(productId)) {
                    this.openCart();
                } else {
                    await this.addItem(productId);
                }
            });
        });
    }

    initDate() {


        const dateFromInput = document.getElementById('rend_date_from');
        const dateToInput = document.getElementById('rend_date_to');
        if (!dateFromInput || !dateToInput) return;

        const today = new Date();
        const endDate = new Date(today);
        endDate.setDate(endDate.getDate() + this.rentalDays);

        const todayStr = today.toISOString().split('T')[0];
        const endStr = endDate.toISOString().split('T')[0];

        dateFromInput.min = todayStr;
        dateFromInput.value = todayStr;
        dateToInput.min = todayStr;
        dateToInput.value = endStr;

        const handleDateChange = () => {
            // Дата "по" не может быть раньше "с"
            dateToInput.min = dateFromInput.value;
            if (dateToInput.value < dateFromInput.value) {
                dateToInput.value = dateFromInput.value;
            }

            let days = 1;
            if (dateFromInput.value && dateToInput.value) {
                const diff = new Date(dateToInput.value) - new Date(dateFromInput.value);
                days = Math.max(1, diff / (1000 * 60 * 60 * 24));
            }

            this.rentalDays = days;
            this.saveCart();

            const word = this.getDaysWord(days);
            document.getElementById('count_date').textContent = days;
            document.getElementById('name_date').textContent = word;

            this.updateUI();
        };

        dateFromInput.addEventListener('change', handleDateChange);
        dateToInput.addEventListener('change', handleDateChange);

        // Начальное отображение количества дней
        const word = this.getDaysWord(this.rentalDays);
        const countDateEl = document.getElementById('count_date');
        const nameDateEl = document.getElementById('name_date');
        if (countDateEl) countDateEl.textContent = this.rentalDays;
        if (nameDateEl) nameDateEl.textContent = word;
    }

    initModalListener() {
        const modalEl = document.getElementById('modal-order');
        if (!modalEl) return;

        modalEl.addEventListener('show.bs.modal', () => {
            const summary = this.getCartSummary();

            // Заполняем скрытые поля
            document.getElementById('modal-cart-items').value = JSON.stringify(summary.items);
            document.getElementById('modal-cart-total').value = summary.total;
            document.getElementById('modal-cart-deposit').value = summary.deposit;
            document.getElementById('modal-rental-days').value = summary.rentalDays;

            // Дата аренды — берём из flatpickr если есть
            const dateInput = document.getElementById('rend_date');
            if (dateInput && dateInput._flatpickr) {
                const dates = dateInput._flatpickr.selectedDates;
                if (dates.length === 2) {
                    const fmt = d => d.toISOString().split('T')[0];
                    document.getElementById('modal-cart-dates').value = `${fmt(dates[0])} — ${fmt(dates[1])}`;
                }
            }

            // Опционально: показать сводку в модалке
            const summaryEl = document.getElementById('modal-cart-summary');
            if (summaryEl) {
                const hasRental = summary.items.some(i => i.rent);
                summaryEl.innerHTML = `
                <ul class="list-unstyled mb-2">
                    ${summary.items.map(i => `<li>${i.title} × ${i.quantity}</li>`).join('')}
                </ul>
                <p class="mb-1">Итого: <strong>$${this.formatPrice(summary.total)}</strong>${hasRental ? ` + залог: <strong>$${this.formatPrice(summary.deposit)}</strong>` : ''}</p>
                ${hasRental ? `<p class="mb-0 text-muted"><small>Аренда: ${summary.rentalDays} ${this.getDaysWord(summary.rentalDays)}</small></p>` : ''}
            `;
            }
        });
    }

    initAddedModal() {
        document.getElementById('addedPopupCheckout').addEventListener('click', () => {
            bootstrap.Modal.getInstance(document.getElementById('addedToCartModal')).hide();
            this.openCart();
        });
    }

    showAddedModal(product) {
        const pricePerDay = this.getItemPrice(product);

        document.getElementById('addedPopupItem').innerHTML = `
        <img src="${product.thumb}" alt="${product.title}" 
             width="70" height="70" class="rounded-3 object-fit-cover flex-shrink-0">
        <div class="d-flex flex-column gap-1">
            <span class="fw-medium">${product.title}</span>
            <small class="text-muted">${product.rent ? 'Аренда' : 'Цена'}:
                <strong class="text-dark">$ ${this.formatPrice(pricePerDay)}${product.rent ? ' / день' : ''}</strong>
            </small>
        </div>
    `;

        const modal = new bootstrap.Modal(document.getElementById('addedToCartModal'));
        modal.show();
    }

    initEventListeners() {
        const cartIcons = document.querySelectorAll('.cartIcon');
        cartIcons.forEach(el => {
            el.addEventListener('click', () => this.openCart());
        })
        document.getElementById('closeCart').addEventListener('click', () => this.closeCart());
        document.getElementById('overlay').addEventListener('click', () => this.closeCart());
    }

    openCart() {
        document.getElementById('miniCart').classList.add('open');
        document.getElementById('overlay').classList.add('active');
    }

    closeCart() {
        document.getElementById('miniCart').classList.remove('open');
        document.getElementById('overlay').classList.remove('active');
    }

    clearCart() {
        this.items = {};
        this.rentalDays = 1;
        localStorage.removeItem('cart');
        this.updateUI();

        const dateInput = document.getElementById('rend_date');
        if (dateInput && dateInput._flatpickr) {
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            dateInput._flatpickr.setDate([today, tomorrow]);
        }

        // Сбрасываем отображение дней
        const countDateEl = document.getElementById('count_date');
        const nameDateEl = document.getElementById('name_date');
        if (countDateEl) countDateEl.textContent = '1';
        if (nameDateEl) nameDateEl.textContent = 'день';
    }
}

// Инициализация корзины
document.addEventListener('DOMContentLoaded', () => {
    window.cart = new Cart();
    document.addEventListener('pb:after', event => {
        if (location.pathname === '/shop') {
            window.cart.initButton();
            window.cart.updateButtons();
        }
    })
})
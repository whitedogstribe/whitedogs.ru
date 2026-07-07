document.addEventListener('pb:success', (e) => {
    let { form } = e.detail;
    if (!form) return;
    if (form.id === 'form-signup' || form.id === 'form-tour') {
        ym(94121619,'reachGoal','form');
    }
});

document.addEventListener('DOMContentLoaded', () => {

    if (typeof Fancybox == 'object') {
        Fancybox.bind("[data-fancybox]");
    }

    if (typeof Carousel == 'function') {

        const carouselMobile = document.querySelectorAll(".f-carousel-mobile");
        carouselMobile.forEach(item => {
            let mobileCarousel = Carousel(item, {
                center: true,
                infinite: false,
                enabled: true,
                breakpoints: {
                    "(min-width: 768px)": {
                        enabled: false,
                    },
                },
            }).init();

            let btnPrev = item.querySelectorAll('.carousel-prev');
            btnPrev.forEach(btn => {
                btn.addEventListener('click', () => {
                    mobileCarousel.prev();
                })
            });

            let btnNext = item.querySelectorAll('.carousel-next');
            btnNext.forEach(btn => {
                btn.addEventListener('click', () => {
                    mobileCarousel.next();
                })
            });
        });

        const sliders = document.querySelectorAll(".f-carousel-center");
        sliders.forEach(item => {
            Carousel(item, {
                center: true,
                infinite: false
            }).init();
        });

        const carouselDefaults = document.querySelectorAll(".f-carousel-default");
        carouselDefaults.forEach((item, index) => {
            setTimeout(() => {
                Carousel(item, {
                    Autoplay: {
                        showProgressbar: false,
                        timeout: 6000,
                    },
                    center: true,
                    infinite: false
                }, { Dots, Autoplay }).init();
            }, index * 500);
        });
    }

    if (typeof Choices == 'function') {
        const selects = document.querySelectorAll('.js-choice');
        selects.forEach(select => {
            new Choices(select);
        })
    }

    // pbMessage.setSuccessHandler((ctx, message) => {
    //     Swal.fire({
    //         icon: "success",
    //         toast: true,
    //         position: "top-end",
    //         timer: 3000,
    //         showConfirmButton: false,
    //         text: message
    //     });
    // });

    pbMessage.setSuccessHandler((ctx, hash) => {
        const modals = document.querySelectorAll('.modal.show');
        modals.forEach(modal => {
            bootstrap.Modal.getInstance(modal).hide();
        });
        cart.clearCart();
        cart.closeCart();

        const formAction = ctx['action'].split('/').pop();
        if (formAction === 'anketa') {
            Swal.fire({
                title: 'Анкета отправлена! 🥳',
                text: 'Спасибо! Мы получили вашу анкету и скоро свяжемся с вами.',
                confirmButtonText: 'Отлично!',
                confirmButtonColor: '#20C19C',
                showCancelButton: false,
            });
        } else if (formAction === 'order') {
            Swal.fire({
                title: 'Заказ успешно отправлен 🥳',
                html: `
                        <p>Мы скоро свяжемся с вами!<br>
                        <small class="text-muted">(обычно в течение суток)</small></p>
                        <p>Если потребуется что-то изменить в заказе или уточнить детали — пишите нам:<br>
                        <a href="https://t.me/whitedogstribe" target="_blank" rel="nofollow" style="color:#20C19C;font-weight:bold;">@whitedogstribe</a></p>
                    `,
                confirmButtonText: 'Закрыть',
                confirmButtonColor: '#20C19C',
                showCancelButton: false,
            });
        } else {
            Swal.fire({ // tour / cta / footer / contacts
                title: 'Заявка успешно отправлена! 🥳',
                text: 'Мы внимательно относимся к атмосфере в группе и поэтому анкетируем всех участников. Будем рады если вы заполните анкету прямо сейчас:',
                confirmButtonText: 'Заполнить анкету',
                confirmButtonColor: '#20C19C',
                showCancelButton: false,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = `/anketa?${hash}`;
                }
            });
        }
    });

    pbMessage.setErrorHandler((ctx, message) => {
        Swal.fire({
            icon: "error",
            toast: true,
            position: "top-end",
            timer: 3000,
            showConfirmButton: false,
            text: message
        });
    });

    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

    const modal = document.getElementById('modal-signup');
    if (modal) {
        modal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;

            const tour_name = button.getAttribute('data-title');
            const tour_url = button.getAttribute('data-url');
            const date = button.getAttribute('data-date');
            const dates = JSON.parse(button.getAttribute('data-dates') || '{}');
            const price = button.getAttribute('data-price');
            const selectDate = modal.querySelector('#selectDate');
            const select = selectDate ? selectDate.querySelector('select') : null;

            modal.querySelector('[name="tour_name"]').value = tour_name;
            modal.querySelector('[name="tour_url"]').value = tour_url;
            modal.querySelector('[name="tour_date"]').value = date;
            modal.querySelector('#modal-tour-title').innerHTML = tour_name;
            modal.querySelector('#modal-tourdate-input').value = date;

            if (dates.length) {
                if (dates.length > 1) {
                    select.innerHTML = '';
                    dates.forEach(function (date) {
                        const option = document.createElement('option');
                        option.value = date.date;
                        option.textContent = `${date.date} (${date.price})`;
                        select.appendChild(option);
                    });
                    selectDate.style.display = 'block';
                } else {
                    modal.querySelector('#modal-tourdate').style.display = 'none';
                    modal.querySelector('#modal-tourdate').innerHTML = `${date} (${price})`;
                    modal.querySelector('#modal-tourdate').style.display = 'block';
                    selectDate.style.display = 'none';
                }
            }
        });
    }

    let elPrices = document.querySelectorAll('.price');
    let tourDates = document.querySelectorAll('input.tour-dates');
    let selectDays = document.querySelectorAll('.changePrice');
    let tourDiscount = document.querySelectorAll('.tour-discount');
    let tourOldPrices = document.querySelectorAll('.tour-old-price');

    selectDays.forEach(select => {
        select.addEventListener('change', el => {
            let date = el.target.value;
            let price = el.target.selectedOptions[0].dataset.price;
            let clear_price = el.target.selectedOptions[0].dataset.clear_price;
            let old_price = el.target.selectedOptions[0].dataset.old_price;
            let discount = el.target.selectedOptions[0].dataset.discount;
            let start_date = el.target.selectedOptions[0].dataset.start_date;

            Tour.price = clear_price;
            Tour.start_date = start_date;
            faqParser();

            elPrices.forEach(el => {
                el.innerText = price;
            });

            tourDates.forEach(el => {
                el.value = date;
            });

            tourOldPrices.forEach(el => {
                el.innerText = old_price;
            });

            tourDiscount.forEach(el => {
                el.innerText = discount;
            });

            selectDays.forEach(s => {
                if (s !== this) {
                    s.value = date;
                }
            });
        })
    });

    let faqParser = function () {
        if (typeof Tour === 'undefined') return;
        let faqPrices = document.querySelectorAll('.faq-discount-price');
        faqPrices.forEach(el => {
            el.textContent = Tour.price * 0.2 + Tour.currency;
        })

        let date2 = new Date(Tour.start_date);
        date2.setMonth(date2.getMonth() - 2);
        let day2 = String(date2.getDate()).padStart(2, '0');
        let month2 = String(date2.getMonth() + 1).padStart(2, '0');
        let year2 = String(date2.getFullYear()).slice(-2);

        let faqDate2 = document.querySelectorAll('.faq-2-months');
        faqDate2.forEach(el => {
            el.textContent = `${ day2}.${ month2}.${ year2}`;
        });

        let date3 = new Date(Tour.start_date);
        date3.setMonth(date3.getMonth() - 2);
        let day3 = String(date3.getDate()).padStart(2, '0');
        let month3 = String(date3.getMonth() + 1).padStart(2, '0');
        let year3 = String(date3.getFullYear()).slice(-2);

        let faqDate3 = document.querySelectorAll('.faq-3-months');
        faqDate3.forEach(el => {
            el.textContent = `${ day3}.${ month3}.${ year3}`;
        });
    }
    faqParser();


    document.querySelectorAll('a[href^="#"][data-link-type="url"]').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const target = document.querySelector(link.getAttribute('href'));
            if (!target) return;

            const navHeight = document.querySelector('.header').offsetHeight;
            const top = target.getBoundingClientRect().top + window.scrollY - navHeight;
            window.scrollTo({ top, behavior: 'smooth' });
        });
    });

});
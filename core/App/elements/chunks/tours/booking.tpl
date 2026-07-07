<section class="booking-section pt-4 pb-5">
    <div class="container">
        <h2 class="text-uppercase text-center font-cofo">{$title}</h2>

        <div class="row justify-content-center">
            <div class="col-auto mb-4">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="text">
                        <h3 class="step-title">Оставьте<br>заявку</h3>
                        <a href="#">Заявка</a>
                    </div>
                </div>
            </div>

            <div class="col-auto mb-4">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="text">
                        <h3 class="step-title">Заполните<br>короткую<br><a href="">анкету</a></h3>
                        <p class="step-description">Мы с вами<br>познакомимся</p>
                    </div>
                </div>
            </div>

            <div class="col-auto mb-4">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="text">
                        <h3 class="step-title">Внесите<br>предоплату</h3>
                        <p class="step-description">30% от цены</p>
                    </div>
                </div>
            </div>

            <div class="col-auto mb-4">
                <div class="step-card">
                    <div class="step-number">4</div>
                    <div class="text">
                        <h3 class="step-title">Вуаля!<br>Вы в группе!</h3>
                        <p class="step-description">Добро пожаловать<br>в поход</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .booking-section {
            background: rgb(245, 245, 245);
        }
        .step-card {
            display: flex;
            gap:1rem;
            padding: 30px 20px;
            transition: transform 0.3s ease;
        }

        .step-card:hover {
            transform: translateY(-10px);
        }

        .step-number {
            font-size: 4rem;
            font-weight: 700;
            color: #e0e0e0;
            margin-bottom: 20px;
            line-height: 1;
        }

        .step-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .step-card a {
            color: #00bcd4;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .step-card a:hover {
            color: #0097a7;
        }

        .step-description {
            color: #7f8c8d;
            font-size: 1.1rem;
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .step-number {
                font-size: 3rem;
            }
            .step-card {
                margin-bottom: 30px;
            }
        }
    </style>
</section>
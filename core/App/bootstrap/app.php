<?php

return [
    'middleware' => [
        'modauth' => MODAuthenticate::class,
        'csrf' => VerifyCsrfToken::class,
        'g-recaptcha-v3' => VerifyGoogleRecaptchaV3::class,
        'auth' => Authenticate::class,
        'guest' => Guest::class,
        'api' => API::class,
        'shop' => Shop::class,
    ]
];
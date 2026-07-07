<?php

return [
    'error_failed'        => 'Validierung fehlgeschlagen.',
    'error_missing'       => 'Das Feld :attribute fehlt.',
    'error_csrf'          => 'CSRF-Token stimmt nicht überein.',
    'error_recaptcha'     => 'reCAPTCHA-Überprüfung fehlgeschlagen. Bitte versuchen Sie es erneut.',

    // Boolean
    'error_accepted'      => 'Das Feld :attribute muss akzeptiert werden.',
    'error_accepted_if'   => 'Das Feld :attribute muss akzeptiert werden, wenn :other gleich :value ist.',
    'error_boolean'       => 'Das Feld :attribute muss ein boolescher Wert sein.',
    'error_declined'      => 'Das Feld :attribute muss abgelehnt werden.',
    'error_declined_if'   => 'Das Feld :attribute muss abgelehnt werden, wenn :other gleich :value ist.',

    // String
    'error_alpha'          => 'Das Feld :attribute darf nur Buchstaben enthalten.',
    'error_alpha_num'      => 'Das Feld :attribute darf nur Buchstaben und Zahlen enthalten.',
    'error_alpha_dash'     => 'Das Feld :attribute darf nur Buchstaben, Zahlen, Bindestriche und Unterstriche enthalten.',
    'error_regex'          => 'Das Feld :attribute hat ein ungültiges Format.',
    'error_string'         => 'Das Feld :attribute muss ein nicht-leerer String sein.',
    'error_email'          => 'Das Feld :attribute muss eine gültige E-Mail-Adresse sein.',
    'error_confirmed'      => 'Die Bestätigung für :attribute stimmt nicht mit :other überein.',
    'error_different'      => 'Das Feld :attribute muss sich von :other unterscheiden.',
    'error_same'           => 'Das Feld :attribute muss mit :other übereinstimmen.',
    'error_in'             => 'Das Feld :attribute muss einer der folgenden Werte sein: :types.',
    'error_not_in'         => 'Das Feld :attribute darf keiner der folgenden Werte sein: :types.',
    'error_json'           => 'Das Feld :attribute muss ein gültiger JSON-String sein.',
    'error_lowercase'      => 'Das Feld :attribute muss in Kleinbuchstaben sein.',
    'error_uppercase'      => 'Das Feld :attribute muss in Großbuchstaben sein.',
    'error_min_length'     => 'Das Feld :attribute muss mindestens :count Zeichen enthalten.',
    'error_max_length'     => 'Das Feld :attribute darf nicht mehr als :count Zeichen enthalten.',
    'error_url'            => 'Das Feld :attribute muss eine gültige URL sein.',
    'error_uuid'           => 'Das Feld :attribute muss eine gültige UUID sein.',
    'error_min_string'     => 'Das Feld :attribute muss mindestens :count Zeichen enthalten.',
    'error_max_string'     => 'Das Feld :attribute darf nicht mehr als :count Zeichen enthalten.',
    'error_size_string'    => 'Das Feld :attribute muss genau :count Zeichen enthalten.',
    'error_between_string' => 'Das Feld :attribute muss zwischen :min und :max Zeichen enthalten.',

    // Numbers
    'error_numeric'         => 'Das Feld :attribute muss eine Zahl sein.',
    'error_integer'         => 'Das Feld :attribute muss eine ganze Zahl sein.',
    'error_decimal'         => 'Das Feld :attribute muss zwischen :min und :max Dezimalstellen haben.',
    'error_gt'              => 'Das Feld :attribute muss größer als :other sein.',
    'error_gte'             => 'Das Feld :attribute muss größer oder gleich :other sein.',
    'error_lt'              => 'Das Feld :attribute muss kleiner als :other sein.',
    'error_lte'             => 'Das Feld :attribute muss kleiner oder gleich :other sein.',
    'error_min_digits'      => 'Das Feld :attribute muss mindestens :count Ziffern enthalten.',
    'error_max_digits'      => 'Das Feld :attribute darf höchstens :count Ziffern enthalten.',
    'error_min_numeric'     => 'Das Feld :attribute muss mindestens :count betragen.',
    'error_max_numeric'     => 'Das Feld :attribute darf nicht größer als :count sein.',
    'error_size_numeric'    => 'Das Feld :attribute muss :count sein.',
    'error_between_numeric' => 'Das Feld :attribute muss zwischen :min und :max liegen.',

    // Arrays
    'error_array'         => 'Das Feld :attribute muss ein Array sein.',
    'error_contains'      => 'Das Feld :attribute muss mindestens einen der folgenden Werte enthalten: :types.',
    'error_distinct'      => 'Das Feld :attribute enthält doppelte Werte.',
    'error_in_array'      => 'Das Feld :attribute muss in :other vorhanden sein.',
    'error_min_array'     => 'Das Feld :attribute muss mindestens :count Elemente enthalten.',
    'error_max_array'     => 'Das Feld :attribute darf nicht mehr als :count Elemente enthalten.',
    'error_size_array'    => 'Das Feld :attribute muss genau :count Elemente enthalten.',
    'error_between_array' => 'Das Feld :attribute muss zwischen :min und :max Elemente enthalten.',

    // Dates
    'error_date'               => 'Das Feld :attribute ist kein gültiges Datum.',
    'error_date_equals'        => 'Das Feld :attribute muss ein Datum gleich :other sein.',
    'error_date_format'        => 'Das Feld :attribute entspricht nicht dem Format: :types.',
    'error_before'             => 'Das Feld :attribute muss ein Datum vor :other sein.',
    'error_before_or_equal'    => 'Das Feld :attribute muss ein Datum vor oder gleich :other sein.',
    'error_after'              => 'Das Feld :attribute muss ein Datum nach :other sein.',
    'error_after_or_equal'     => 'Das Feld :attribute muss ein Datum nach oder gleich :other sein.',

    // Files
    'error_file'         => 'Das Feld :attribute muss eine Datei sein.',
    'error_image'        => 'Das Feld :attribute muss ein Bild sein.',
    'error_mimes'        => 'Die Datei :attribute muss einen der folgenden Typen haben: :types.',
    'error_extensions'   => 'Die Datei :attribute muss eine der folgenden Erweiterungen haben: :types.',
    'error_dimensions'   => 'Das Bild :attribute hat ungültige Abmessungen.',
    'error_min_file'     => 'Die Datei :attribute muss mindestens :count Kilobyte groß sein.',
    'error_max_file'     => 'Die Datei :attribute darf nicht größer als :count Kilobyte sein.',
    'error_size_file'    => 'Die Datei :attribute muss genau :count Kilobyte groß sein.',
    'error_between_file' => 'Die Datei :attribute muss zwischen :min und :max Kilobyte groß sein.',

    // File list
    'error_min_files'     => 'Das Feld :attribute muss mindestens :count Dateien enthalten.',
    'error_max_files'     => 'Das Feld :attribute darf nicht mehr als :count Dateien enthalten.',
    'error_size_files'    => 'Das Feld :attribute muss genau :count Dateien enthalten.',
    'error_between_files' => 'Das Feld :attribute muss zwischen :min und :max Dateien enthalten.',

    // Database
    'error_unique' => 'Der Wert von :attribute ist bereits vergeben.',
    'error_exists' => 'Der Wert von :attribute ist bereits in der Datenbank vorhanden.',

    // Utilities
    'error_required'     => 'Das Feld :attribute ist erforderlich.',
    'error_required_if'  => 'Das Feld :attribute ist erforderlich, wenn :other gleich :value ist.',
    'error_filled'       => 'Das Feld :attribute darf nicht leer sein.',
    'error_nullable'     => 'Das Feld :attribute darf null sein.',
    'error_empty'        => 'Das Feld :attribute muss leer sein.',
];
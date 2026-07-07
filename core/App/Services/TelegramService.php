<?php

namespace PageBlocks\App\Services;

use GuzzleHttp\Client;

class TelegramService
{
    const TELEGRAM_BOT_TOKEN = '6250339479:AAFSrXcGp3t7ZEkgBYwXP7BCKxJirEkU7zw';

    const TELEGRAM_CHAT_IDS = [
        ['chat_id' => '-1001982937909', 'message_thread_id' => 1189],
    ];
    const TELEGRAM_SHOP_IDS = [
        ['chat_id' => '-1001982937909', 'message_thread_id' => 18914],
    ];

    const TELEGRAM_PERSONAL_CHAT_IDS = [
        ['chat_id' => '1954560911'], // Эрадж
        ['chat_id' => '301229518'], // Boshnik
    ];

    const TELEGRAM_TEST_CHAT_IDS = [
        ['chat_id' => '301229518'], // Boshnik
        ['chat_id' => '1954560911'], // Эрадж
    ];

    const MODE_TEST = false;

    public static function notify(string $formName, array $data): void
    {
        $text = static::buildMessage($formName, $data);

        if (self::MODE_TEST) {
            foreach (self::TELEGRAM_TEST_CHAT_IDS as $chat) {
                static::sendMessage($chat, $text);
            }
        } else {
            foreach (self::TELEGRAM_PERSONAL_CHAT_IDS as $chat) {
                static::sendMessage($chat, $text);
            }

            if (in_array($formName, ['signup', 'tour'])) {
                foreach (self::TELEGRAM_CHAT_IDS as $chat) {
                    static::sendMessage($chat, $text);
                }
            }

            if (in_array($formName, ['order'])) {
                foreach (self::TELEGRAM_SHOP_IDS as $chat) {
                    static::sendMessage($chat, $text);
                }
            }
        }
    }

    protected static function sendMessage(array $chat, string $text): void
    {
        if (empty($chat['chat_id'])) {
            return;
        }

        try {
            $client = new Client([
                'base_uri' => 'https://api.telegram.org/bot' . self::TELEGRAM_BOT_TOKEN . '/',
                'timeout'  => 10,
            ]);

            $payload = [
                'chat_id'    => $chat['chat_id'],
                'text'       => $text,
                'parse_mode' => 'HTML',
            ];

            if (!empty($chat['message_thread_id'])) {
                $payload['message_thread_id'] = $chat['message_thread_id'];
            }

            $client->post('sendMessage', ['json' => $payload]);
        } catch (\Exception $e) {
            // TODO: добавить лог
        }
    }

    protected static function buildMessage(string $formName, array $data): string
    {
        return match($formName) {
            'anketa' => static::buildAnketaMessage($data),
            'tour' => static::buildTourMessage($data),
            'order' => static::buildOrderMessage($data),
            default  => static::buildDefaultMessage($data),
        };
    }

    protected static function buildTourMessage(array $data): string
    {
        $contact = match($data['contactType'] ?? null) {
            'telegram' => "Telegram: <a href=\"tg://resolve?domain={$data['contact']}\">{$data['contact']}</a>\n",
            'whatsapp' => "WhatsApp: <a href=\"https://wa.me/{$data['contact']}\">{$data['contact']}</a>\n",
            'email'    => "Email: <a href=\"mailto:{$data['contact']}\">{$data['contact']}</a>\n",
            default    => '',
        };

        $utms = '';
        $utmFields = ['utm_content', 'utm_medium', 'utm_source', 'utm_campaign'];
        foreach ($utmFields as $field) {
            if (!empty($data[$field])) {
                $utms .= "{$field}: {$data[$field]}\n";
            }
        }

        return sprintf(
            "<b>%s</b> хочет в поход 🏕️\n" .
            "<a href=\"%s\">%s</a>\n\n" .
            "%s\n\n" .
            "%s" .
            "%s",
            htmlspecialchars($data['name'] ?? '—'),
            htmlspecialchars($data['tour_url'] ?? '#'),
            htmlspecialchars($data['tour_name'] ?? '—'),
            htmlspecialchars($data['tour_date'] ?? '—'),
            $contact,
            $utms ? "\n" . $utms : ''
        );
    }

    protected static function buildAnketaMessage(array $data): string
    {
        $filled = self::gender($data['fullname'] ?? '') === 'male' ? 'заполнил' : 'заполнила';

        $anketaFields = [
            $data['fullname']        ?? '',
            $data['prepayment']       ?? '',
            $data['left']      ?? '',
            $data['notes']      ?? '',
            $data['phone']      ?? '',
            $data['email']      ?? '',
            $data['messenger']      ?? '',
            $data['social']      ?? '',
            $data['birthdate']      ?? '',
            $data['from_city']      ?? '',
            $data['t-shirt']      ?? '',
            $data['question2']      ?? '',
            $data['question3']      ?? '',
            $data['question4']      ?? '',
            $data['question5']      ?? '',
            $data['question6']      ?? '',
            $data['question7']      ?? '',
            $data['question8']      ?? '',
            $data['question9']      ?? '',
            $data['question10']      ?? '',
            $data['question14']      ?? '',
            $data['question11']      ?? '',
            $data['question12']      ?? '',
            $data['question13']      ?? '',
            $data['question1']      ?? '',
        ];

        $anketaString = implode(';', $anketaFields);

        return sprintf(
            "<b>%s</b> {$filled} анкету 🎉\n" .
            "<a href=\"%s\">%s</a>\n\n" .
            "%s\n\n" .
            "<code>%s</code>",
            htmlspecialchars($data['fullname'] ?? '—'),
            htmlspecialchars($data['tour_url'] ?? '#'),
            htmlspecialchars($data['tour_name'] ?? '—'),
            htmlspecialchars($data['tour_date'] ?? '—'),
            htmlspecialchars($anketaString)
        );
    }

    protected static function buildDefaultMessage(array $data): string
    {
        $contact = match($data['contactType'] ?? null) {
            'telegram' => "Telegram: <a href=\"tg://resolve?domain={$data['contact']}\">{$data['contact']}</a>\n",
            'whatsapp' => "WhatsApp: <a href=\"https://wa.me/{$data['contact']}\">{$data['contact']}</a>\n",
            'email'    => "Email: <a href=\"mailto:{$data['contact']}\">{$data['contact']}</a>\n",
            default    => $data['contact'],
        };

        $send = self::gender($data['name'] ?? '') === 'male' ? 'отправил' : 'отправила';

        $utms = '';
        $utmFields = ['utm_content', 'utm_medium', 'utm_source', 'utm_campaign'];
        foreach ($utmFields as $field) {
            if (!empty($data[$field])) {
                $utms .= "{$field}: {$data[$field]}\n";
            }
        }

        return sprintf(
            "<b>%s</b> {$send} заявку на обратную связь\n" .
            "%s" .
            "%s",
            htmlspecialchars($data['name'] ?? '—'),
            $contact,
            $utms ? "\n" . $utms : ''
        );
    }

    protected static function buildOrderMessage(array $data): string
    {
        $send = self::gender($data['name'] ?? '') === 'male' ? 'оформил' : 'оформила';

        $contact = match($data['contactType'] ?? null) {
            'telegram' => "Telegram: <a href=\"tg://resolve?domain={$data['contact']}\">{$data['contact']}</a>\n",
            'whatsapp' => "WhatsApp: <a href=\"https://wa.me/{$data['contact']}\">{$data['contact']}</a>\n",
            'email'    => "Email: <a href=\"mailto:{$data['contact']}\">{$data['contact']}</a>\n",
            default    => ($data['contact'] ?? '') . "\n",
        };

        $itemsJson = $data['cart_items'] ?? '[]';
        $items = json_decode($itemsJson, true) ?: [];

        $itemLines = '';
        $hasRental = false;
        foreach ($items as $item) {
            $pricePerDay = (float)($item['pricePerDay'] ?? 0);
            $qty = (int)($item['quantity'] ?? 1);
            $isRent = !empty($item['rent']);

            if ($isRent) {
                $hasRental = true;
                $days = (int)($data['rental_days'] ?? 1);
                $itemTotal = $pricePerDay * $days * $qty;
                $itemLines .= sprintf(
                    "  • %s × %d × %d д. = <b>$%s</b>\n",
                    htmlspecialchars($item['title'] ?? '—'),
                    $qty,
                    $days,
                    number_format($itemTotal, 0, '.', ' ')
                );
            } else {
                $itemTotal = $pricePerDay * $qty;
                $itemLines .= sprintf(
                    "  • %s × %d = <b>$%s</b>\n",
                    htmlspecialchars($item['title'] ?? '—'),
                    $qty,
                    number_format($itemTotal, 0, '.', ' ')
                );
            }
        }

        $total    = (float)($data['cart_total'] ?? 0);
        $deposit  = (float)($data['cart_deposit'] ?? 0);
        $days     = (int)($data['rental_days'] ?? 0);

        $rentalLine = '';
        if ($hasRental && !empty($data['cart_dates'])) {
            $daysWord = match(true) {
                $days % 100 >= 11 && $days % 100 <= 14 => 'дней',
                $days % 10 === 1 => 'день',
                $days % 10 >= 2 && $days % 10 <= 4 => 'дня',
                default => 'дней',
            };
            $rentalLine = sprintf(
                "\n📅 Аренда: <b>%s</b> (%d %s)\n",
                htmlspecialchars($data['cart_dates']),
                $days,
                $daysWord
            );
        }

        $depositLine = $deposit > 0
            ? sprintf("💰 Залог: <b>$%s</b>\n", number_format($deposit, 0, '.', ' '))
            : '';

        return sprintf(
            "🛒 <b>%s</b> {$send} заказ\n\n" .
            "%s\n" .
            "%s" .
            "💵 Итого: <b>$%s</b>\n" .
            "%s" .
            "%s",
            htmlspecialchars($data['name'] ?? '—'),
            $itemLines,
            $rentalLine,
            number_format($total, 0, '.', ' '),
            $depositLine,
            $contact
        );
    }

    protected static function gender(string $first = ''): string {
        $isShortenedName = fn(string $name) => (bool)preg_match('/^\p{L}{1,3}\.$/u', trim($name));
        $first = $isShortenedName($first) ? '' : $first;

        $firstGender = null;
        if ($first && mb_strlen($first) > 3 && !preg_match('/[a-z]$/i', $first)) {
            if (preg_match('/й$|он$|ан$|ен$|ин$|ун$|ор$|ар$|ер$|ир$|ур$|ел$|ил$|ол$|ем$|им$|ит$|ов$|ев$|ид$|иг$/ui', $first)) $firstGender = 'male';
            elseif (preg_match('/а$|я$|ь$/u', $first)) $firstGender = 'female';
        }

        if ($firstGender) return $firstGender;

        return 'male';
    }
}
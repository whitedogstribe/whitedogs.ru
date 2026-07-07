<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use Boshnik\PageBlocks\Facades\Validator;
use PageBlocks\App\Models\pbTableData;
use PageBlocks\App\Models\Tour;
use PageBlocks\App\Services\TelegramService;

class FormController extends BaseController
{
    protected TelegramService $telegram;

    public function __construct(\modX $modx, TelegramService $telegram)
    {
        parent::__construct($modx);
        $this->telegram = $telegram;
    }

    public function submit(string $alias, Request $request)
    {
        $formName = $alias;
        $labels = [
            'name' => 'Имя',
            'contact' => 'Контакт',
            'contactType' => 'Тип контакта',
            'tour_name' => 'Тур',
            'tour_date' => 'Дата тура',
            'page' => 'Страница',
        ];
        $validateFields = [
            'name' => 'required|string|max:255',
            'contact' => 'required|string|max:255',
        ];

        $messages = [
            'name.required' => 'Поле обязательно для заполнения',
            'contact.required' => 'Поле обязательно для заполнения',
        ];

        switch ($alias) {
            case 'contacts':
                $validateFields['confirm'] = 'accepted|exclude';
                break;
            case 'cta':
                $validateFields['contactType'] = 'required';
                $validateFields['page'] = 'required|string';
            case 'tour':
                $validateFields['contactType'] = 'required';
                $validateFields['tour_url'] = 'nullable|string';
                $validateFields['tour_name'] = 'nullable|string';
                $validateFields['tour_date'] = 'nullable|string';
                break;
            case 'footer':
                $validateFields['contactType'] = 'required';
                break;
            case 'anketa':
                $fields = PbTableData::where([
                    'model_type' => 'PageBlocks\App\Models\PbBlockData',
                    'model_id' => 777,
                    'constructor_id' => 33,
                    'field_id' => 395,
                ])
                    ->whereNotNull("published_at")
                    ->where("published_at", '<=', now())
                    ->whereNull("deleted_at")
                    ->get()
                    ->map(function ($field) {
                        return $field->data;
                    });

                $labels = [];
                $validateFields = [];
                foreach ($fields as $field) {
                    $labels[$field['name']] = $field['title'];
                    if ($field['required']) {
                        $validateFields[$field['name']] = 'required|string|max:255';
                    } else {
                        $validateFields[$field['name']] = 'nullable|string|max:255';
                    }
                }

                $tour_name = $request->get('tour_name');
                if ($tour_name) {
                    $tour = Tour::where('id', $tour_name)->first();
                    $request->set('tour_name', $tour->title);
                    $request->set('tour_url', 'tours/' . $tour->alias);
                }

                $day = $request->get('birthdate-day',  '01');
                $month = $request->get('birthdate-month',  'Январь');
                $year = $request->get('birthdate-year',  '1970');
                $request->set('birthdate', "{$day}.{$month}.{$year}");

                break;
            case 'order':
                break;
            default:
                $formName = '';
        }

        $validator = Validator::make($request->all(), $validateFields, $messages);

        if (empty($formName)) {
            return response()->error('Форма не найдена!');
        }

        if ($validator->fails()) {
            return response()->error('Упс! Валидация не пройдена!', $validator->errors());
        }

        try {
            $validated = $validator->validated();
            $values = [];
            foreach ($validated as $key => $value) {
                $newKey = $labels[$key] ?? $key;
                $values[$newKey] = $value;
            }

            $formData = [
                'form' => $formName,
                'values' => json_encode($values),
                'ip' => $request->ip(),
                'context_key' => $this->modx->context->key,
                'date' => time(),
            ];

            query('formit_forms')->insert($formData);

            // Отправляем в Telegram
            TelegramService::notify($formName, $request->all());

            if (!$tour && isset($validated['tour_url'])) {
                $url = explode('/', $validated['tour_url']);
                $alias = end($url);
                $tour = Tour::where('alias', $alias)->first();
            }

            $query = [
                'tour_id' => $tour ? $tour->id : null,
                'start_date' => $validated['tour_date']
                    ? $this->parseStartDate($validated['tour_date'])
                    : '',
                'contactType' => $validated['contactType'],
                'contact' => $validated['contact'],
            ];

            if ($alias === 'anketa') {
                return response()->success();
            }

            return response()->success(http_build_query($query));

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Произошла ошибка при сохранении формы',
                'error' => $e->getMessage()
            ], 500);
        }

    }

    public function parseStartDate(string $input): string {
        $months = [
            'января' => '01', 'февраля' => '02', 'марта' => '03',
            'апреля' => '04', 'мая' => '05', 'июня' => '06',
            'июля' => '07', 'августа' => '08', 'сентября' => '09',
            'октября' => '10', 'ноября' => '11', 'декабря' => '12',
        ];

        $input = trim($input);

        // Формат: "11-17 октября 2026"
        if (preg_match('/^(\d+)-\d+\s+(\S+)\s+(\d{4})$/', $input, $m)) {
            $day   = str_pad($m[1], 2, '0', STR_PAD_LEFT);
            $month = $months[$m[2]] ?? null;
            $year  = $m[3];
            if ($month) return "$year-$month-$day";
        }

        // Формат: "28 марта - 7 апреля 2026"
        if (preg_match('/^(\d+)\s+(\S+)\s*-\s*\d+\s+\S+\s+(\d{4})$/', $input, $m)) {
            $day   = str_pad($m[1], 2, '0', STR_PAD_LEFT);
            $month = $months[$m[2]] ?? null;
            $year  = $m[3];
            if ($month) return "$year-$month-$day";
        }

        return '';
    }

}
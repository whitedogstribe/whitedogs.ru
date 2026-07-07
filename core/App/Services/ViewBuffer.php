<?php

namespace PageBlocks\App\Services;

class ViewBuffer
{
    private static function bufferPath(): string
    {
        $date = date('Y-m-d');
        return MODX_CORE_PATH . "cache/views_buffer_{$date}.json";
    }

    public static function push(string $modelType, int $modelId): void
    {
        $path = self::bufferPath();
        $key  = $modelType . ':' . $modelId;

        // flock — защита от race condition при параллельных запросах
        $fp = fopen($path, 'c+');
        if (!flock($fp, LOCK_EX)) {
            fclose($fp);
            return;
        }

        $content = stream_get_contents($fp);
        $data    = $content ? json_decode($content, true) : [];

        $data[$key] = ($data[$key] ?? 0) + 1;

        rewind($fp);
        ftruncate($fp, 0);
        fwrite($fp, json_encode($data));
        flock($fp, LOCK_UN);
        fclose($fp);
    }

    public static function flush(): array
    {
        $path = self::bufferPath();
        if (!file_exists($path)) {
            return [];
        }

        $fp = fopen($path, 'c+');
        flock($fp, LOCK_EX);

        $content = stream_get_contents($fp);
        $data    = $content ? json_decode($content, true) : [];

        rewind($fp);
        ftruncate($fp, 0);

        flock($fp, LOCK_UN);
        fclose($fp);

        return $data;
    }
}
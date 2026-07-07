<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property int $id
 * @property string $name
 * @property string $description
 * @property string $class_key
 * @property array|null $properties
 * @property int $is_stream
 */
class Source extends Model
{
    protected $table = 'sources';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'description',
        'class_key',
        'properties',
        'is_stream',
    ];

    protected $casts = [
        'id' => 'integer',
        'properties' => 'array',
        'is_stream' => 'boolean',
    ];

    protected $attributes = [
        'class_key' => 'sources.modFileMediaSource',
        'is_stream' => 1,
    ];

    public function getBasePath()
    {
        return $this->getProperty('basePath', '');
    }

    public function getBaseUrl()
    {
        return $this->getProperty('baseUrl', '');
    }

    public function isFileSystem()
    {
        return $this->class_key === 'sources.modFileMediaSource';
    }

    public function isS3()
    {
        return $this->class_key === 'sources.modS3MediaSource';
    }

    public function getFilePath($file)
    {
        $basePath = $this->getBasePath();

        if (empty($basePath)) {
            return $file;
        }

        return rtrim($basePath, '/') . '/' . ltrim($file, '/');
    }

    public function getFileUrl($file)
    {
        $baseUrl = $this->getBaseUrl();

        if (empty($baseUrl)) {
            return $file;
        }

        return rtrim($baseUrl, '/') . '/' . ltrim($file, '/');
    }
}
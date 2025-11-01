<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Storage;

class StorageHelper
{
    /**
     * Get the full public URL for a file stored in S3/Object Storage
     *
     * @param string|null $path
     * @return string|null
     */
    public static function getStorageUrl(?string $path): ?string
    {
        if (empty($path)) {
            return null;
        }

        // Get AWS configuration from environment
        $awsUrl = config('filesystems.disks.s3.url');
        $awsBucket = config('filesystems.disks.s3.bucket');

        // Build the full URL
        if ($awsUrl && $awsBucket) {
            return rtrim($awsUrl, '/') . '/' . ltrim($awsBucket, '/') . '/' . ltrim($path, '/');
        }

        return null;
    }

    /**
     * Get multiple storage URLs at once
     *
     * @param array $paths Array of paths to convert
     * @return array Array of URLs with same keys as input
     */
    public static function getStorageUrls(array $paths): array
    {
        $urls = [];
        foreach ($paths as $key => $path) {
            $urls[$key] = self::getStorageUrl($path);
        }
        return $urls;
    }
}

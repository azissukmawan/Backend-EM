<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use setasign\Fpdi\Tcpdf\Fpdi;

class SertifikatGenerator
{
    /**
     * Generate sertifikat dengan overlay text dan konversi ke PDF
     *
     * @param string $templatePath Path template di S3 (relatif)
     * @param string $namaPeserta Nama peserta
     * @param string $noSertifikat Nomor sertifikat
     * @param string $namaAcara Nama acara
     * @param string $tanggalSertifikat Tanggal acara
     * @return string|null Path file sertifikat PDF yang sudah di-generate
     */
    public static function generate(
        string $templatePath,
        string $namaPeserta,
        string $noSertifikat,
        string $namaAcara = '',
        string $tanggalSertifikat = ''
    ): ?string {
        try {
            // Download template dari S3
            $templateContent = Storage::disk('s3')->get($templatePath);

            if (!$templateContent) {
                Log::error("Template sertifikat tidak ditemukan: $templatePath");
                return null;
            }

            // Simpan ke temporary file
            $tempTemplate = sys_get_temp_dir() . '/' . Str::random(10) . '.jpg';
            file_put_contents($tempTemplate, $templateContent);

            // Get image info
            $imageInfo = getimagesize($tempTemplate);
            $mimeType = $imageInfo['mime'];

            // Load image sesuai tipe
            switch ($mimeType) {
                case 'image/jpeg':
                    $img = imagecreatefromjpeg($tempTemplate);
                    break;
                case 'image/png':
                    $img = imagecreatefrompng($tempTemplate);
                    break;
                default:
                    throw new \Exception("Format image tidak didukung: $mimeType");
            }

            if (!$img) {
                throw new \Exception("Gagal load template image");
            }

            // Dapatkan dimensi gambar
            $width = imagesx($img);
            $height = imagesy($img);

            // $fontPath = public_path('fonts/MomoSignature-Regular.ttf');
            $fontPathNomor = public_path('fonts/montserrat/Montserrat-Regular.ttf');
            $fontPathNama = public_path('fonts/montserrat/Montserrat-SemiBold.ttf');



            // 1. NOMOR SERTIFIKAT (di atas)

            $nomorText = "Nomor: $noSertifikat";
            $nomorFontSize = 45; // Ukuran font lebih besar
            $nomorPosY = (int)($height * 0.29);
            $nomorColor = imagecolorallocate($img, 100, 100, 100); // Biru gelap

            // Hitung lebar text untuk center alignment
            $nomorBox = imagettfbbox($nomorFontSize, 0, $fontPathNomor, $nomorText);
            $nomorWidth = abs($nomorBox[4] - $nomorBox[0]);
            $nomorPosX = (int)(($width - $nomorWidth) / 2);

            imagettftext($img, $nomorFontSize, 0, $nomorPosX, $nomorPosY, $nomorColor, $fontPathNomor, $nomorText);

            // ✅ 2. NAMA PESERTA (di tengah)
            $namaFontSize = 80; // Font lebih besar untuk nama
            $namaPosY = (int)($height * 0.43);
            $namaColor = imagecolorallocate($img, 0, 102, 128); // Hitam

            // Hitung lebar text untuk center alignment
            $namaBox = imagettfbbox($namaFontSize, 0, $fontPathNama, $namaPeserta);
            $namaWidth = abs($namaBox[4] - $namaBox[0]);
            $namaPosX = (int)(($width - $namaWidth) / 2);

            imagettftext($img, $namaFontSize, 0, $namaPosX, $namaPosY, $namaColor, $fontPathNama, $namaPeserta);

            // Resize image jika terlalu besar (untuk target PDF <1MB)
            $img = self::resizeImageIfNeeded($img, $width, $height);

            // Update dimensions setelah resize
            $width = imagesx($img);
            $height = imagesy($img);

            // Generate nama file unik
            $fileName = 'sertifikat_' . time() . '_' . Str::random(10) . '.jpg';
            $outputPath = sys_get_temp_dir() . '/' . $fileName;

            // Simpan hasil ke file sementara dengan kompresi optimal
            imagejpeg($img, $outputPath, 80); // Quality 80 untuk balance antara size & quality

            // Bersihkan memory
            imagedestroy($img);

            // Konversi image ke PDF dengan compression
            $pdfPath = self::convertImageToPdf($outputPath, $namaPeserta);

            // Verify PDF size dan compress jika masih perlu
            $compressedPdfPath = self::compressPdf($pdfPath, $outputPath);

            // Upload PDF ke S3
            $pdfFileName = 'sertifikat_' . time() . '_' . Str::random(10) . '.pdf';
            $s3Path = 'sertifikat-generated/' . $pdfFileName;
            Storage::disk('s3')->put($s3Path, file_get_contents($compressedPdfPath), 'public');

            // Hapus file temp
            @unlink($tempTemplate);
            @unlink($outputPath);
            @unlink($pdfPath);
            if ($compressedPdfPath !== $pdfPath) {
                @unlink($compressedPdfPath);
            }

            return $s3Path;
        } catch (\Exception $e) {
            Log::error('Error generating sertifikat: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());

            if (isset($tempTemplate) && file_exists($tempTemplate)) {
                @unlink($tempTemplate);
            }
            if (isset($outputPath) && file_exists($outputPath)) {
                @unlink($outputPath);
            }
            if (isset($img) && is_resource($img)) {
                imagedestroy($img);
            }

            return null;
        }
    }

    /**
     * Convert image (JPG/PNG) to PDF with compression
     *
     * @param string $imagePath Path to image file
     * @param string $title PDF title
     * @return string Path to generated PDF
     */
    private static function convertImageToPdf(string $imagePath, string $title = 'Sertifikat'): string
    {
        // Get image dimensions
        list($width, $height) = getimagesize($imagePath);

        // Calculate PDF dimensions (convert pixels to mm, assuming 96 DPI)
        $pdfWidth = ($width * 25.4) / 96;
        $pdfHeight = ($height * 25.4) / 96;

        // Create new PDF document with custom page size
        $pdf = new Fpdi('L', 'mm', [$pdfWidth, $pdfHeight], true, 'UTF-8', false);

        // Set document information
        $pdf->SetCreator('Event Management AirNav');
        $pdf->SetAuthor('Event Management AirNav');
        $pdf->SetTitle($title);

        // Remove default header/footer
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        // Set margins
        $pdf->SetMargins(0, 0, 0);
        $pdf->SetAutoPageBreak(false, 0);

        // Enable compression
        $pdf->SetCompression(true);

        // Add a page
        $pdf->AddPage();

        // Add image to PDF (lower DPI from 300 to 150 untuk reduce size)
        $pdf->Image($imagePath, 0, 0, $pdfWidth, $pdfHeight, '', '', '', false, 150, '', false, false, 0);

        // Generate output file
        $outputPath = sys_get_temp_dir() . '/' . Str::random(10) . '.pdf';
        $pdf->Output($outputPath, 'F');

        return $outputPath;
    }

    /**
     * Resize image jika dimensi terlalu besar
     * Target: Max width 2480px untuk A4 landscape @ 150 DPI
     *
     * @param resource $img GD image resource
     * @param int $currentWidth Current width
     * @param int $currentHeight Current height
     * @return resource Resized image or original
     */
    private static function resizeImageIfNeeded($img, int $currentWidth, int $currentHeight)
    {
        // Target max width untuk A4 landscape @ 150 DPI
        $maxWidth = 2480;
        $maxHeight = 1754;

        // Jika sudah cukup kecil, return as-is
        if ($currentWidth <= $maxWidth && $currentHeight <= $maxHeight) {
            return $img;
        }

        Log::info("Resizing image from {$currentWidth}x{$currentHeight}");

        // Calculate new dimensions (maintain aspect ratio)
        $ratio = min($maxWidth / $currentWidth, $maxHeight / $currentHeight);
        $newWidth = (int)($currentWidth * $ratio);
        $newHeight = (int)($currentHeight * $ratio);

        // Create new image
        $resized = imagecreatetruecolor($newWidth, $newHeight);

        // Preserve transparency for PNG
        imagealphablending($resized, false);
        imagesavealpha($resized, true);

        // Resize
        imagecopyresampled($resized, $img, 0, 0, 0, 0, $newWidth, $newHeight, $currentWidth, $currentHeight);

        // Destroy original
        imagedestroy($img);

        Log::info("Resized to {$newWidth}x{$newHeight}");

        return $resized;
    }

    /**
     * Compress PDF file jika ukurannya >1MB
     * Fallback: Re-compress JPG source dengan quality lebih rendah
     *
     * @param string $pdfPath Path to PDF file
     * @param string $jpgPath Path to source JPG (optional)
     * @return string Path to compressed PDF (same or new file)
     */
    private static function compressPdf(string $pdfPath, string $jpgPath = null): string
    {
        $fileSize = filesize($pdfPath);
        $maxSize = 1 * 1024 * 1024; // 1MB in bytes

        // Jika sudah <1MB, return as-is
        if ($fileSize <= $maxSize) {
            Log::info("✅ PDF size OK: " . round($fileSize / 1024 / 1024, 2) . "MB");
            return $pdfPath;
        }

        Log::warning("⚠️ PDF too large: " . round($fileSize / 1024 / 1024, 2) . "MB, attempting compression...");

        // Jika ada source JPG, coba re-compress dengan quality lebih rendah
        if ($jpgPath && file_exists($jpgPath)) {
            try {
                $img = imagecreatefromjpeg($jpgPath);
                if (!$img) {
                    throw new \Exception("Failed to load JPG for re-compression");
                }

                // Save dengan quality sangat rendah (60)
                $compressedJpg = sys_get_temp_dir() . '/' . Str::random(10) . '_compressed.jpg';
                imagejpeg($img, $compressedJpg, 60);
                imagedestroy($img);

                // Re-generate PDF
                $compressedPdf = self::convertImageToPdf($compressedJpg, 'Sertifikat');

                $newSize = filesize($compressedPdf);
                Log::info("🔄 Compressed PDF size: " . round($newSize / 1024 / 1024, 2) . "MB");

                // Cleanup temp JPG
                @unlink($compressedJpg);

                // Jika masih >1MB, warn tapi tetap return
                if ($newSize > $maxSize) {
                    Log::warning("⚠️ Compressed PDF still >1MB. Consider using lower resolution template.");
                }

                return $compressedPdf;
            } catch (\Exception $e) {
                Log::error("Compression failed: " . $e->getMessage());
            }
        }

        // Fallback: return original
        Log::warning("⚠️ Using original PDF. Recommend admin to upload lower resolution template (<2000px width).");
        return $pdfPath;
    }
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .container {
            background-color: #f4f4f4;
            border-radius: 10px;
            padding: 30px;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 10px 10px 0 0;
            margin: -30px -30px 20px -30px;
        }
        .otp-code {
            background-color: #fff;
            border: 2px dashed #4CAF50;
            padding: 20px;
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 10px;
            margin: 20px 0;
            border-radius: 5px;
        }
        .info {
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Email Verification</h1>
        </div>

        <p>Hello <strong>{{ $userName }}</strong>,</p>

        <p>Thank you for registering! To complete your registration, please use the following OTP code:</p>

        <div class="otp-code">
            {{ $otpCode }}
        </div>

        <div class="info">
            <p><strong>Important:</strong></p>
            <ul>
                <li>This OTP code will expire in <strong>10 minutes</strong></li>
                <li>Do not share this code with anyone</li>
                <li>If you didn't request this code, please ignore this email</li>
            </ul>
        </div>

        <div class="footer">
            <p>This is an automated message, please do not reply to this email.</p>
            <p>&copy; {{ date('Y') }} Event Management System. All rights reserved.</p>
        </div>
    </div>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .email-container {
            max-width: 600px;
            margin: 30px auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #ffffff;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            margin: 0;
            font-size: 28px;
        }
        .content {
            padding: 40px 30px;
        }
        .content p {
            color: #333333;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .reset-button {
            display: inline-block;
            background-color: #667eea;
            color: #ffffff;
            text-decoration: none;
            padding: 14px 30px;
            border-radius: 5px;
            font-weight: bold;
            margin: 20px 0;
            transition: background-color 0.3s;
        }
        .reset-button:hover {
            background-color: #5568d3;
        }
        .link-container {
            background-color: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            margin: 20px 0;
            word-break: break-all;
        }
        .link-container a {
            color: #667eea;
            text-decoration: none;
        }
        .warning {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin: 20px 0;
        }
        .warning p {
            margin: 0;
            color: #856404;
            font-size: 14px;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 20px 30px;
            text-align: center;
            color: #6c757d;
            font-size: 12px;
        }
        .footer p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="header">
            <h1>🔐 Reset Password</h1>
        </div>

        <div class="content">
            <p>Hi <strong>{{ $userName }}</strong>,</p>

            <p>We received a request to reset your password for your AirNav Event Management account.</p>

            <p>Click the button below to reset your password:</p>

            <center>
                <a href="{{ $resetLink }}" class="reset-button">Reset Password</a>
            </center>

            <p>Or copy and paste this link into your browser:</p>

            <div class="link-container">
                <a href="{{ $resetLink }}">{{ $resetLink }}</a>
            </div>

            <div class="warning">
                <p>⚠️ <strong>Important:</strong> This link will expire in 60 minutes for security reasons.</p>
            </div>

            <p>If you didn't request a password reset, please ignore this email. Your password will remain unchanged.</p>

            <p>For security reasons, never share this link with anyone.</p>

            <p>Best regards,<br>
            <strong>AirNav Event Management Team</strong></p>
        </div>

        <div class="footer">
            <p>&copy; 2025 AirNav Indonesia. All rights reserved.</p>
            <p>This is an automated email, please do not reply to this message.</p>
        </div>
    </div>
</body>
</html>

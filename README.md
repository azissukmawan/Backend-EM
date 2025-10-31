# Backend Event Management - Laravel 12

Backend API untuk Event Management System menggunakan Laravel 12 dengan fitur authentication dan landing page.

## 🔐 Security Features

Aplikasi ini dilengkapi dengan fitur keamanan komprehensif:

- **Account Locking**: Otomatis mengunci akun setelah 5 kali gagal login (durasi 15 menit)
- **Smart Rate Limiting**: Pembatasan request per endpoint dengan strategi per-user
- **OTP Cooldown**: Mencegah spam OTP dengan cooldown 2 menit
- **Production Error Hiding**: Menyembunyikan detail error teknis di production mode
- **Email Verification**: Validasi email sebelum akun dapat digunakan
- **Password Security**: Hash dengan bcrypt
- **Token-based Authentication**: Laravel Sanctum untuk API security
- **CORS Protection**: Konfigurasi CORS untuk keamanan cross-origin

Detail lengkap: Lihat [SECURITY_DOCUMENTATION.md](SECURITY_DOCUMENTATION.md)

## 📚 Documentation

- **[API_DOCUMENTATION.md](API_DOCUMENTATION.md)** - Complete API endpoints reference
- **[SECURITY_DOCUMENTATION.md](SECURITY_DOCUMENTATION.md)** - Security features & implementation guide
- **[LANDING_PAGE_API_DOCUMENTATION.md](LANDING_PAGE_API_DOCUMENTATION.md)** - Landing page API endpoints
- **[BACKEND_FLOW_DOCUMENTATION.md](BACKEND_FLOW_DOCUMENTATION.md)** - Backend flow & architecture
- **[SETUP_AUTH_API.md](SETUP_AUTH_API.md)** - Authentication setup guide
- **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - Testing procedures

## 🚀 Quick Start

### Prerequisites
- PHP >= 8.2
- Composer
- MySQL Database
- Node.js & NPM (for frontend assets)

### Installation

1. Clone repository:
```bash
git clone <repository-url>
cd Backend-EM
```

2. Install dependencies:
```bash
composer install
npm install
```

3. Setup environment:
```bash
cp .env.example .env
php artisan key:generate
```

4. Configure database di `.env`:
```env
DB_CONNECTION=mysql
DB_HOST=your-host
DB_PORT=3306
DB_DATABASE=your-database
DB_USERNAME=your-username
DB_PASSWORD=your-password
```

5. Configure mail di `.env`:
```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your-email@gmail.com
MAIL_FROM_NAME="${APP_NAME}"
```

6. Run migrations:
```bash
php artisan migrate
```

7. Start development server:
```bash
php artisan serve
```

## 🔑 Main Features

### Authentication API
- User Registration dengan email verification
- Login/Logout dengan account locking protection
- OTP Verification dengan cooldown protection
- Password Reset dengan rate limiting
- Token-based authentication

### Landing Page API
- Event listing (upcoming, past, all)
- Event details
- Public access tanpa authentication

## 🛡️ Security Configuration

### Rate Limiting
| Endpoint | Limit | Key Strategy |
|----------|-------|--------------|
| Login | 15/min | email + IP |
| OTP | 5/min | email + IP |
| Reset Password | 5/5min | IP only |

### Account Locking
- Threshold: 5 failed login attempts
- Lock duration: 15 minutes
- HTTP Status: 423 (Locked)

### Production Mode
Set `APP_DEBUG=false` di `.env` untuk production mode yang akan:
- Menyembunyikan detail error database
- Menyembunyikan detail error email
- Hanya menampilkan pesan error umum

## 📝 Testing

Run unit tests:
```bash
php artisan test
```

Detail testing procedures: Lihat [TESTING_GUIDE.md](TESTING_GUIDE.md)

## 📦 Tech Stack

- **Framework**: Laravel 12
- **Database**: MySQL
- **Authentication**: Laravel Sanctum
- **Email**: Laravel Mail + SMTP
- **Testing**: Pest PHP
- **API**: RESTful API

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

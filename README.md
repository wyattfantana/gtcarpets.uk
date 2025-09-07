# GT Carpets UK

A Ruby on Rails web application for GT Carpets, providing carpet and vinyl fitting services with an integrated price calculator.

🌐 **Website**: [gtcarpets.uk](https://gtcarpets.uk)  
📂 **Repository**: [github.com/wyattfantana/gtcarpets.uk.git](https://github.com/wyattfantana/gtcarpets.uk.git)

## Features

- **Price Calculator**: Interactive calculator for carpet and vinyl fitting costs
- **Service Information**: Details about carpet and vinyl fitting services
- **Contact System**: Email integration using SendGrid for customer inquiries
- **Responsive Design**: Mobile-friendly interface with navigation
- **Professional Layout**: Clean design with hero sections and footer

## Technology Stack

- **Framework**: Ruby on Rails 7.0
- **Ruby Version**: 3.3.5
- **Database**: SQLite3
- **Styling**: SCSS/Sass
- **JavaScript**: CoffeeScript, Turbolinks
- **Email Service**: SendGrid
- **Server**: Puma

## Installation & Setup

### Prerequisites
- Ruby 3.3.5
- Rails 7.0
- SQLite3

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/wyattfantana/gtcarpets.uk.git
   cd gt_carpets_app
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Environment Configuration**
   - Copy `.env.example` to `.env` (if available)
   - Configure SendGrid API key in `.env`

4. **Database Setup**
   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Start the server**
   ```bash
   rails server
   ```

The application will be available at `http://localhost:3000`

## Application Structure

### Controllers
- `ApplicationController` - Base controller
- `PagesController` - Static pages (home, about, services)
- `CarpetsController` - Price calculator functionality
- `ContactsController` - Contact form handling
- `Admin::ApplicationController` - Base admin controller with authentication
- `Admin::DashboardController` - Unified admin dashboard
- `Admin::PricesController` - Price management
- `Admin::SettingsController` - Content management
- `Admin::SessionsController` - Admin authentication

### Key Features Detail

#### Admin Panel
**URL**: `/admin/login` (Password: Set via `ADMIN_PASSWORD` environment variable)

**Unified Dashboard Features**:
- **Content Management**: Edit About Us and Our Expertise sections directly
- **Price Management**: Update all calculator pricing with inline editing
- **Calculator Toggle**: Enable/disable the entire price calculator
- **Contact Management**: Update business contact information (name, phone, email)
- **Reset to Defaults**: Safety feature to restore original pricing
- **Responsive Design**: Mobile-friendly admin interface

**Database-Driven Content**:
- All website content stored in `Settings` model
- All pricing stored in `Price` model with fallback values
- Changes reflect immediately on the live website

#### Price Calculator
Located in `CarpetsController#price_calculator`, calculates costs using database values:
- Carpet fitting: Configurable (default £7.50/sqm)
- Vinyl fitting: Configurable (default £10.50/sqm) 
- Additional materials: All pricing configurable through admin panel
- Door trims: Configurable (default £9 each)
- Plyboarding for vinyl: Configurable (default £10.50/sqm)
- Minimum charge: Configurable (default £150)

#### Email Integration
- SendGrid integration for contact forms
- Email templates in `app/views/contact_mailer/`

## Development

### Testing
```bash
rails test
```

### Development Server
```bash
rails server
```

### Asset Compilation
```bash
rails assets:precompile
```

## Deployment

### Production Setup
1. **Deploy to hosting platform** (Render, Heroku, etc.)
2. **Set environment variables**:
   - `ADMIN_PASSWORD` - Admin panel login password
   - `SENDGRID_API_KEY` - For email functionality
   - `RECAPTCHA_SITE_KEY` - For contact form protection

3. **Run database setup**:
   ```bash
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```

### Post-Deployment
- **Admin Access**: `https://yoursite.com/admin/login`
- **Database Seeding**: Creates initial pricing and content settings
- **Content Management**: All website content becomes editable via admin panel

The application is configured for deployment with:
- Puma web server
- Environment variables for configuration
- SendGrid for email services
- SQLite database (easily replaceable with PostgreSQL for production)

## Project Structure

```
app/
├── controllers/          # Application controllers
│   └── admin/           # Admin panel controllers
├── models/              # Data models
│   ├── price.rb         # Price management model
│   └── setting.rb       # Content management model
├── views/               # View templates
│   ├── admin/           # Admin panel views
│   │   └── dashboard/   # Unified admin dashboard
│   ├── carpets/         # Price calculator views
│   ├── contact_mailer/  # Email templates
│   ├── layouts/         # Layouts including admin layout
│   └── shared/          # Shared partials (header, footer, hero)
├── assets/              # Stylesheets, JavaScript, images
config/                  # Application configuration
db/                      # Database files and migrations
│   ├── migrate/         # Database migrations
│   └── seeds.rb         # Initial data seeding
public/                  # Static assets
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is proprietary software for GT Carpets UK.

## Contact

For technical issues or questions about this application, please contact the development team through the repository issues page.
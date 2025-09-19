# Street Thugs Salonica Press Card Generator

A Flutter web application for generating international press identification cards for Street Thugs Salonica journalists, videographers, and photographers.

## Overview

This application creates professional press cards with bilingual support (Greek/English) featuring:
- Front side with photo, personal information, and credentials
- Back side with organization details, QR code, and legal text
- Custom styling with carbon fiber backgrounds and professional layout
- Screenshot functionality for card download

## Features

- **Bilingual Forms**: Input fields for both Greek and English personal information
- **Role Selection**: Choose from Journalist, Videographer, or Photographer roles
- **Photo Upload**: Select and display user photos on the press card
- **QR Code Integration**: Customizable QR codes linking to verification URLs
- **Card Generation**: Generate both front and back sides of press cards
- **Download Functionality**: Download cards as PNG images
- **Professional Design**: Carbon fiber styling with organizational branding

## Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Dependencies**:
  - `image_picker`: Photo selection functionality
  - `screenshot`: Card image generation
  - `custom_qr_generator`: QR code creation
  - `auto_size_text_plus`: Responsive text sizing
  - `universal_html`: Web-specific HTML functionality

## Getting Started

### Prerequisites

- Flutter SDK (3.4.0 or higher)
- Dart SDK
- Web browser for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd sts_press
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d web
```

## Usage

1. **Fill Personal Information**: Enter name, surname, and nationality in both Greek and English
2. **Select Role**: Choose from the dropdown (Journalist/Videographer/Photographer)
3. **Set QR URL**: Enter the URL for QR code verification (defaults to streetthugssalonica.org)
4. **Upload Photo**: Click "Επιλέξτε Εικόνα" to select a profile photo
5. **Generate Cards**:
   - Click "Δημιουργία και λήψη κάρτας(front)" for front side
   - Click "Δημιουργία και λήψη κάρτας(back)" for back side

## Assets

The application includes:
- `logo.png`: Organization logo
- `carbon.png`: Carbon fiber background texture
- `ed.png`: Union/organization emblem

## Card Features

### Front Side
- Profile photograph
- Bilingual personal information
- Card ID number (randomly generated)
- Role/capacity designation
- Expiration date (fixed: 31/12/2026)
- Organization membership details

### Back Side
- Organizational information
- Legal text in Greek and English
- Contact information
- QR code for verification
- Professional styling

## Build Information

- **Version**: 1.0.0+1
- **Environment**: SDK 3.4.0 to 4.0.0
- **Platform**: Web-focused with multi-platform support

## Development

The main application logic is contained in `lib/main.dart` with a single-page form interface for card generation.

## Organization

Street Thugs Salonica - Member of the Union of Magazine and Electronic Press Journalists

**Contact**: streetthugssalonica@gmail.com
**Website**: www.streetthugssalonica.org
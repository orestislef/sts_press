# Street Thugs Salonica Press Card Generator

A modern Flutter web application for generating international press identification cards for Street Thugs Salonica journalists, videographers, and photographers.

![Flutter](https://img.shields.io/badge/Flutter-3.4.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Web](https://img.shields.io/badge/Platform-Web-blue)

## 🌟 Features

### Interactive Card Preview
- **Flip Card Animation**: Tap/click to flip between front and back views
- **Zoom & Pan**: Pinch to zoom (0.5x - 3x) and pan around the card
- **Real-time Preview**: See changes instantly as you type
- **Responsive Design**: Works perfectly on mobile, tablet, and desktop

### Bilingual Support
- Greek and English input fields
- Automatic bilingual card generation
- Professional international format

### Card Generation
- **Front Side**: Photo, personal info, credentials, card ID, expiration date
- **Back Side**: Organization details, QR code, legal text, contact info
- **High Quality**: 3x pixel ratio for crisp downloads
- **Custom QR Codes**: Link to verification URLs

### User Experience
- Clean Material Design 3 interface
- Desktop: Side-by-side layout (preview + form)
- Mobile: Optimized stacked layout
- Icon-enhanced form fields
- Success/error notifications
- Loading indicators

## 🚀 Live Demo

**Production URL**: [https://orestislef.gr/sts_press/](https://orestislef.gr/sts_press/)

## 📋 Prerequisites

- Flutter SDK (≥3.4.0 <4.0.0)
- Dart SDK
- Web browser (Chrome, Firefox, Safari, Edge)

## 🛠️ Installation

1. **Clone the repository**:
```bash
git clone <repository-url>
cd sts_press
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Run in debug mode**:
```bash
flutter run -d chrome --debug
```

4. **Build for production**:
```bash
MSYS_NO_PATHCONV=1 flutter build web --base-href=/sts_press/
```

## 📂 Project Structure

```
lib/
├── constants/
│   └── app_constants.dart          # App-wide constants
├── utils/
│   └── id_generator.dart           # Card ID generation utility
├── widgets/
│   ├── press_card_widget.dart      # Reusable press card component
│   └── bilingual_text_field.dart   # Bilingual input widget
├── screens/
│   └── press_card_form_screen.dart # Main form screen
└── main.dart                        # App entry point

assets/
└── images/
    ├── logo.png                     # Organization logo
    ├── carbon.png                   # Carbon fiber background
    └── ed.png                       # Union emblem
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.2.0              # Photo selection
  screenshot: ^3.0.0                # Card image generation
  auto_size_text: ^3.0.0            # Responsive text
  custom_qr_generator: ^0.1.2       # QR code creation
  universal_html: ^2.2.4            # Web-specific functionality
  flip_card: ^0.7.0                 # Flip animation
  flutter_native_splash: ^2.4.6     # Splash screen
  cupertino_icons: ^1.0.8           # iOS icons
```

## 💻 Usage

### 1. Fill Personal Information
- Enter **Name** (Όνομα / First Name)
- Enter **Surname** (Επώνυμο / Last Name)
- Enter **Nationality** (Εθνικότητα / Ethnicity)

### 2. Select Role
Choose from dropdown:
- Δημοσιογράφος / Journalist
- Βιντεολήπτης / Videographer
- Φωτογράφος / Photographer

### 3. Set QR Code URL
- Default: `https://www.streetthugssalonica.org`
- Can be customized for verification

### 4. Upload Photo
- Click **"Επιλέξτε Εικόνα / Select Image"**
- Choose a profile photo (JPG, PNG)
- Preview appears immediately

### 5. Generate Cards
- **Front**: Click "Δημιουργία και λήψη κάρτας (Μπροστά)"
- **Back**: Click "Δημιουργία και λήψη κάρτας (Πίσω)"
- Files download as `press_card_front.png` and `press_card_back.png`

## 🎨 Card Specifications

### Front Side
- **Dimensions**: 600x400px (3:2 ratio)
- **Profile Photo**: 150x200px with rounded corners
- **Card ID**: Auto-generated 4-digit number (0XXX)
- **Expiration**: 31/12/2026
- **Design**: Carbon fiber background, professional layout

### Back Side
- **QR Code**: 150x150px with gradient styling
- **Text**: Bilingual legal disclaimer
- **Contact**: Email and website
- **Branding**: Organization logos and colors

## 🌐 Deployment

### Build for Production

```bash
# Windows (Git Bash)
MSYS_NO_PATHCONV=1 flutter build web --base-href=/sts_press/

# Linux/macOS
flutter build web --base-href=/sts_press/
```

### Upload to Server

1. Build output location: `build/web/`
2. Upload **all contents** to: `your-domain.com/sts_press/`
3. Required files:
   - `index.html`
   - `main.dart.js`
   - `flutter.js`, `flutter_bootstrap.js`
   - `assets/`, `canvaskit/`, `icons/`, `splash/` folders
   - `manifest.json`, `version.json`

### Server Requirements
- Static file hosting (Apache, Nginx, etc.)
- HTTPS recommended
- No server-side code required
- Serves `index.html` as default document

## 🔧 Development

### Hot Reload
Press `r` in terminal during debug mode

### Hot Restart
Press `R` in terminal during debug mode

### DevTools
Access at: `http://localhost:9102?uri=http://localhost:XXXX`

## 🐛 Troubleshooting

### Assets not loading
- Ensure base-href is set correctly: `/sts_press/`
- Check all files uploaded to server
- Verify folder structure is maintained

### Splash screen not showing
- Check `splash/img/light-background.png` exists
- Verify `index.html` has correct base href

### Icons missing
- Ensure `icons/` folder uploaded
- Check `manifest.json` paths

## 📱 Browser Compatibility

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+
- ✅ Mobile browsers (iOS Safari, Chrome Mobile)

## 📄 License

This project is part of Street Thugs Salonica media operations.

## 🏢 Organization

**Street Thugs Salonica**
Member of the Union of Magazine and Electronic Press Journalists

**Contact**: streetthugssalonica@gmail.com
**Website**: [www.streetthugssalonica.org](https://www.streetthugssalonica.org)

## 🙏 Credits

- Built with [Flutter](https://flutter.dev)
- QR Code generation by [custom_qr_generator](https://pub.dev/packages/custom_qr_generator)
- Flip animation by [flip_card](https://pub.dev/packages/flip_card)

---

**Version**: 1.0.0+1
**Last Updated**: October 2025
**Maintained by**: Street Thugs Salonica Development Team

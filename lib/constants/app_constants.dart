/// Application-wide constants
class AppConstants {
  // App information
  static const String appTitle = 'Street Thugs Salonica Γεννήτρια καρτών';
  static const String defaultQrUrl = 'https://www.streetthugssalonica.org';
  static const String expirationDate = '31/12/2026';

  // Card dimensions
  static const double cardHeight = 400.0;
  static const double cardWidth = 600.0;
  static const double cardBorderRadius = 10.0;

  // Image dimensions
  static const double profileImageWidth = 150.0;
  static const double profileImageHeight = 200.0;

  // QR Code
  static const double qrCodeSize = 150.0;

  // Text sizes
  static const double defaultTextSize = 17.0;

  // Profession options
  static const List<String> professions = [
    'Δημοσιογράφος / Journalist',
    'Βιντεολήπτης / Videographer',
    'Φωτογράφος / Photographer',
  ];

  // Assets
  static const String carbonImage = 'assets/images/carbon.png';
  static const String logoImage = 'assets/images/logo.png';
  static const String edImage = 'assets/images/ed.png';
}

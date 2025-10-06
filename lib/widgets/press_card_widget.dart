import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/id_generator.dart';

/// Main widget for rendering the press card (front or back)
class PressCardWidget extends StatelessWidget {
  final String nameGr;
  final String nameEn;
  final String surnameGr;
  final String surnameEn;
  final String ethnicityGr;
  final String ethnicityEn;
  final String profession;
  final String qrUrl;
  final String expirationDate;
  final Uint8List? imageFile;
  final bool isBack;

  const PressCardWidget({
    super.key,
    required this.nameGr,
    required this.nameEn,
    required this.surnameGr,
    required this.surnameEn,
    required this.ethnicityGr,
    required this.ethnicityEn,
    required this.profession,
    required this.qrUrl,
    required this.expirationDate,
    required this.imageFile,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.cardHeight,
      width: AppConstants.cardWidth,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Card(
        elevation: 10,
        color: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          child: Stack(
            children: [
              _buildBackground(),
              _buildBackgroundLogo(),
              _buildForeground(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCarbonBackground(),
        _buildPressRotated(),
      ],
    );
  }

  Widget _buildCarbonBackground() {
    return SizedBox(
      height: double.infinity,
      width: 85,
      child: Image.asset(
        AppConstants.carbonImage,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildPressRotated() {
    return Stack(
      children: [
        _buildCarbonBackground(),
        const SizedBox(
          height: double.infinity,
          width: 70,
          child: RotatedBox(
            quarterTurns: 3,
            child: Center(
              child: Text(
                'PRESS',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  letterSpacing: 20.0,
                  fontSize: 58,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundLogo() {
    return Center(
      child: Image.asset(
        AppConstants.logoImage,
        opacity: const AlwaysStoppedAnimation(0.2),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildForeground() {
    return isBack ? _buildBackForeground() : _buildFrontForeground();
  }

  Widget _buildFrontForeground() {
    return Row(
      children: [
        _buildImage(),
        _buildCenterInfo(),
        const SizedBox(width: 85),
      ],
    );
  }

  Widget _buildImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageFile == null
                ? const Placeholder(
                    fallbackWidth: AppConstants.profileImageWidth,
                    fallbackHeight: AppConstants.profileImageHeight,
                  )
                : Image.memory(
                    imageFile!,
                    width: AppConstants.profileImageWidth,
                    height: AppConstants.profileImageHeight,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
          child: Text(
            'Μέλος της',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),
          child: Image.asset(
            AppConstants.edImage,
            height: 60,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildId(),
          const SizedBox(height: 20.0),
          _buildInfoField('$nameGr / $nameEn', 'Όνομα/First Name/Vorname'),
          const SizedBox(height: 5.0),
          _buildInfoField('$surnameGr / $surnameEn', 'Επίθετο/Name/Nachname'),
          const SizedBox(height: 5.0),
          _buildInfoField(profession, 'Ιδιότητα/Capacity/Eigenschaft'),
          const SizedBox(height: 5.0),
          _buildInfoField(
              '$ethnicityGr / $ethnicityEn', 'Εθνικότητα/Nationality/Nationalität'),
          const SizedBox(height: 10.0),
          _buildExpiryDate(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'ΔΕΛΤΙΟ ΤΑΥΤΟΤΗΤΑΣ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text('INTERNATIONAL PRESS', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildId() {
    return Column(
      children: [
        Text(
          IdGenerator.generateId(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Αριθμός μητρώου/Card Id/Martikelnummer',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  Widget _buildInfoField(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220.0,
          child: AutoSizeText(
            value,
            minFontSize: 1.0,
            maxLines: 1,
            style: const TextStyle(
              fontSize: AppConstants.defaultTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 230.0,
          child: Divider(height: 1.0, color: Colors.black, thickness: 1.0),
        ),
        Text(label, style: const TextStyle(fontSize: 7)),
      ],
    );
  }

  Widget _buildExpiryDate() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(118.0, 0.0, 0.0, 0.0),
      child: Column(
        children: [
          const Text('EXPIRATION DATE'),
          Text(
            expirationDate,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBackForeground() {
    return Row(
      children: [
        _buildLeftBackForeground(),
        _buildBackCenterForeground(),
      ],
    );
  }

  Widget _buildLeftBackForeground() {
    return const Row(
      children: [
        SizedBox(width: 20),
        SizedBox(
          width: 70,
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              textAlign: TextAlign.center,
              'e-mail: streetthugssalonica@gmail.com\nwww.streetthugssalonica.org',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 3.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackCenterForeground() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        const SizedBox(
          width: 360.0,
          height: 180.0,
          child: AutoSizeText(
            'Τακτικό μέλος της αρθρογραφικής ομάδας Street Thugs Salonica και μέλος της Ένωσης Δημοσιογράφων Περιοδικού και Ηλεκτρονικού Τύπου. Οι αρχές οφείλουν να του εξασφαλίσουν κάθε νόμιμη διευκόλυνση για την άσκηση του λειτουργήματός του. Οι αρχές μπορούν να ταυτοποιήσουν τα στοιχεία είτε σκανάροντας το QR code ή μέσω του ιστότοπου www.streetthugssalonica.org.\n\nRegular member of the Street Thugs Salonica writing team and member of the Union of Magazine and Electronic Press Journalists. The authorities must ensure he receives every legal facility to perform his duties. The authorities can verify the information either by scanning the QR code or through the website www.streetthugssalonica.org.',
            style: TextStyle(fontSize: 35.0),
            minFontSize: 1.0,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CustomPaint(
            size: const Size(
              AppConstants.qrCodeSize,
              AppConstants.qrCodeSize,
            ),
            painter: QrPainter(
              data: qrUrl,
              options: QrOptions(
                shapes: const QrShapes(
                  darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                  frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                  ball: QrBallShapeRoundCorners(cornerFraction: .25),
                ),
                colors: QrColors(
                  background: QrColor.solid(Colors.transparent),
                  dark: QrColorLinearGradient(
                    colors: [Colors.blueGrey[800]!, Colors.blueGrey],
                    orientation: GradientOrientation.leftDiagonal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

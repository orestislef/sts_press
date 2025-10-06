import 'dart:typed_data';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:universal_html/html.dart' as html;
import '../constants/app_constants.dart';
import '../widgets/bilingual_text_field.dart';
import '../widgets/press_card_widget.dart';

/// Main screen for the press card generator form
class PressCardFormScreen extends StatefulWidget {
  const PressCardFormScreen({super.key});

  @override
  State<PressCardFormScreen> createState() => _PressCardFormScreenState();
}

class _PressCardFormScreenState extends State<PressCardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _screenshotController = ScreenshotController();

  // Controllers
  late final TextEditingController _nameGrController;
  late final TextEditingController _nameEnController;
  late final TextEditingController _surnameGrController;
  late final TextEditingController _surnameEnController;
  late final TextEditingController _ethnicityGrController;
  late final TextEditingController _ethnicityEnController;
  late final TextEditingController _qrUrlController;
  late final TextEditingController _expirationDateController;

  // State
  Uint8List? _imageFile;
  bool _isGenerating = false;
  String _selectedProfession = AppConstants.professions.first;

  @override
  void initState() {
    super.initState();
    final debugText = kDebugMode ? 'TEST' : '';
    _nameGrController = TextEditingController(text: debugText);
    _nameEnController = TextEditingController(text: debugText);
    _surnameGrController = TextEditingController(text: debugText);
    _surnameEnController = TextEditingController(text: debugText);
    _ethnicityGrController = TextEditingController(text: debugText);
    _ethnicityEnController = TextEditingController(text: debugText);
    _qrUrlController = TextEditingController(
      text: AppConstants.defaultQrUrl,
    );
    _expirationDateController = TextEditingController(
      text: AppConstants.defaultExpirationDate,
    );
  }

  @override
  void dispose() {
    _nameGrController.dispose();
    _nameEnController.dispose();
    _surnameGrController.dispose();
    _surnameEnController.dispose();
    _ethnicityGrController.dispose();
    _ethnicityEnController.dispose();
    _qrUrlController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          AppConstants.appTitle,
          style: TextStyle(fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 40.0 : 20.0,
          vertical: 20.0,
        ),
        child: Form(
          key: _formKey,
          child: isDesktop
              ? _buildDesktopLayout()
              : _buildMobileLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPreviewCards(),
        const SizedBox(height: 30),
        _buildInputSection(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildPreviewCards(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 1,
          child: _buildInputSection(),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInputFields(),
        const SizedBox(height: 20),
        _buildImagePicker(),
        const SizedBox(height: 30),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildPreviewCards() {
    return Column(
      children: [
        const Text(
          'Προεπισκόπηση / Preview (Tap to flip, Pinch to zoom)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 450,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 3.0,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    front: PressCardWidget(
                      nameGr: _nameGrController.text,
                      nameEn: _nameEnController.text,
                      surnameGr: _surnameGrController.text,
                      surnameEn: _surnameEnController.text,
                      ethnicityGr: _ethnicityGrController.text,
                      ethnicityEn: _ethnicityEnController.text,
                      profession: _selectedProfession,
                      qrUrl: _qrUrlController.text,
                      expirationDate: _expirationDateController.text,
                      imageFile: _imageFile,
                      isBack: false,
                    ),
                    back: PressCardWidget(
                      nameGr: _nameGrController.text,
                      nameEn: _nameEnController.text,
                      surnameGr: _surnameGrController.text,
                      surnameEn: _surnameEnController.text,
                      ethnicityGr: _ethnicityGrController.text,
                      ethnicityEn: _ethnicityEnController.text,
                      profession: _selectedProfession,
                      qrUrl: _qrUrlController.text,
                      expirationDate: _expirationDateController.text,
                      imageFile: _imageFile,
                      isBack: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Στοιχεία Κάρτας / Card Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BilingualTextField(
              grController: _nameGrController,
              enController: _nameEnController,
              grLabel: 'Όνομα',
              grHint: 'Εισάγετε το όνομά σας',
              enLabel: 'First Name',
              enHint: 'Enter your first name',
              validator: (value) => value?.isEmpty ?? true
                  ? 'Παρακαλώ εισάγετε το όνομά σας'
                  : null,
            ),
            const SizedBox(height: 16),
            BilingualTextField(
              grController: _surnameGrController,
              enController: _surnameEnController,
              grLabel: 'Επώνυμο',
              grHint: 'Εισαγάγετε το επώνυμό σας',
              enLabel: 'Last Name',
              enHint: 'Enter your last name',
              validator: (value) => value?.isEmpty ?? true
                  ? 'Παρακαλώ εισάγετε το επώνυμό σας'
                  : null,
            ),
            const SizedBox(height: 16),
            BilingualTextField(
              grController: _ethnicityGrController,
              enController: _ethnicityEnController,
              grLabel: 'Εθνικότητα',
              grHint: 'Εισαγάγετε την εθνικότητα σας',
              enLabel: 'Ethnicity',
              enHint: 'Enter your ethnicity',
              validator: (value) => value?.isEmpty ?? true
                  ? 'Παρακαλώ εισάγετε την εθνικότητα σας'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedProfession,
              decoration: const InputDecoration(
                labelText: 'Ιδιότητα / Profession',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: AppConstants.professions
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProfession = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _qrUrlController,
              decoration: const InputDecoration(
                labelText: 'URL for QR code',
                hintText: 'Please enter your url',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.qr_code),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your url'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _expirationDateController,
              decoration: const InputDecoration(
                labelText: 'Ημερομηνία λήξης / Expiration Date',
                hintText: 'ΗΗ/ΜΜ/ΕΕΕΕ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Παρακαλώ εισάγετε την ημερομηνία λήξης'
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Επιλέξτε Εικόνα / Select Image'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        if (_imageFile != null) ...[
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              _imageFile!,
              width: 200,
              height: 266,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    final canGenerate = !_isGenerating && _imageFile != null;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: canGenerate
                ? () {
                    if (_formKey.currentState!.validate()) {
                      _generateAndDownloadCard(isBack: false);
                    }
                  }
                : null,
            icon: _isGenerating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            label: const Text('Δημιουργία και λήψη κάρτας (Μπροστά)'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: canGenerate
                ? () {
                    if (_formKey.currentState!.validate()) {
                      _generateAndDownloadCard(isBack: true);
                    }
                  }
                : null,
            icon: _isGenerating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            label: const Text('Δημιουργία και λήψη κάρτας (Πίσω)'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = Uint8List.fromList(fileBytes);
      });
    }
  }

  Future<void> _generateAndDownloadCard({required bool isBack}) async {
    setState(() => _isGenerating = true);

    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final screenshot = await _screenshotController.captureFromLongWidget(
        context: context,
        constraints: BoxConstraints.tight(
          const Size(AppConstants.cardWidth, AppConstants.cardHeight),
        ),
        pixelRatio: 3.0,
        PressCardWidget(
          nameGr: _nameGrController.text,
          nameEn: _nameEnController.text,
          surnameGr: _surnameGrController.text,
          surnameEn: _surnameEnController.text,
          ethnicityGr: _ethnicityGrController.text,
          ethnicityEn: _ethnicityEnController.text,
          profession: _selectedProfession,
          qrUrl: _qrUrlController.text,
          expirationDate: _expirationDateController.text,
          imageFile: _imageFile,
          isBack: isBack,
        ),
        delay: const Duration(milliseconds: 100),
      );

      final blob = html.Blob([screenshot], 'image/png');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final filename = 'press_card_${isBack ? 'back' : 'front'}.png';

      html.AnchorElement(href: url)
        ..setAttribute('download', filename)
        ..click();

      html.Url.revokeObjectUrl(url);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Η κάρτα δημιουργήθηκε επιτυχώς! / Card generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Σφάλμα: $e / Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }
}

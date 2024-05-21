import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Street Thugs Salonica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NameForm(),
    );
  }
}

class NameForm extends StatefulWidget {
  const NameForm({super.key});

  @override
  State<NameForm> createState() => _NameFormState();
}

const List<String> _spinnerItems = [
  'Δημοσιογράφος / Journalist',
  'Βιντεολήπτης / Videographer',
  'Φωτογράφος / Photographer',
];

class _NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameGrController = TextEditingController();
  final TextEditingController _nameEnController = TextEditingController();
  final TextEditingController _surnameGrController = TextEditingController();
  final TextEditingController _surnameEnController = TextEditingController();
  final TextEditingController _ethnicityGrController = TextEditingController();
  final TextEditingController _ethnicityEnController = TextEditingController();
  Uint8List? _imageFile;
  final ScreenshotController _screenshotController = ScreenshotController();
  bool hasError = false;
  String errorText = '';
  String _selectedIdetifier = _spinnerItems.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AutoSizeText(
          'Street Thugs Salonica Γεννήτρια καρτών',
          maxLines: 1,
          minFontSize: 1.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  hasError ? Text(errorText) : Container(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameGrController,
                          decoration: const InputDecoration(
                            labelText: 'Όνομα',
                            hintText: 'Εισάγετε το όνομά σας',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Παρακαλώ εισάγετε το όνομά σας';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(' / ', style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _nameEnController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter your first name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _surnameGrController,
                          decoration: const InputDecoration(
                            labelText: 'Επώνυμο',
                            hintText: 'Εισαγάγετε το επώνυμό σας',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Παρακαλώ εισάγετε το επώνυμό σας';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(' / ', style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _surnameEnController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your last name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ethnicityGrController,
                          decoration: const InputDecoration(
                            labelText: 'Εθνικότητα',
                            hintText: 'Εισαγάγετε την εθνικότητα σας',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Παρακαλώ εισάγετε την εθνικότητα σας';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(' / ', style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _ethnicityEnController,
                          decoration: const InputDecoration(
                            labelText: 'Ethnicity',
                            hintText: 'Enter your ethnicity',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your ethnicity';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _selectedIdetifier,
                    onChanged: (value) {
                      setState(() {
                        _selectedIdetifier = value!;
                      });
                    },
                    items: _spinnerItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _pickImage();
                        }
                      },
                      child: const Text('Επιλέξτε Εικόνα'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _imageFile != null
                      ? Image.memory(_imageFile!, width: 200)
                      : Container(),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: isGenerating || _imageFile == null
                          ? null
                          : () {
                              _generateAndDownloadCard();
                            },
                      child: const Text('Δημιουργία και λήψη κάρτας'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = Uint8List.fromList(fileBytes);
      });
    }
  }

  @override
  void dispose() {
    _nameGrController.dispose();
    _nameEnController.dispose();
    _surnameGrController.dispose();
    _surnameEnController.dispose();
    _ethnicityGrController.dispose();
    _ethnicityEnController.dispose();
    super.dispose();
  }

  bool isGenerating = false;

  void _generateAndDownloadCard() {
    setState(() {
      isGenerating = true;
    });
    // Delay before taking a screenshot
    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      // Capture the screenshot
      _screenshotController
          .captureFromLongWidget(
        context: context,
        constraints: BoxConstraints.tight(const Size(600, 400)),
        pixelRatio: 3.0,
        _buildBusinessCard(),
        delay: const Duration(milliseconds: 1000),
      )
          .then((screenshot) {
        // Create a Blob from the screenshot
        final blob = html.Blob([screenshot], 'image/png');
        final url = html.Url.createObjectUrlFromBlob(blob);

        // Create an anchor element and trigger a download
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'press_card.png')
          ..click();

        // Revoke the object URL after download
        html.Url.revokeObjectUrl(url);
      });
    });
  }

  Widget _buildBusinessCard() {
    return Container(
      height: 400,
      width: 600,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Card(
        elevation: 10,
        color: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              _buildBackgroundOfCard(),
              _buildForegroundOfCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundOfCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRedBackground(),
        _buildPressRotated(),
      ],
    );
  }

  Widget _buildForegroundOfCard() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildImage(),
        _buildCenterInfo(),
        const SizedBox(width: 85),
      ],
    );
  }

  Widget _buildRedBackground() {
    return Container(
      height: double.infinity,
      width: 85,
      color: const Color(0xff613431),
    );
  }

  Widget _buildPressRotated() {
    return Container(
      color: const Color(0xff613431),
      child: const SizedBox(
        height: double.infinity,
        width: 85,
        child: RotatedBox(
            quarterTurns: 3,
            child: Center(
              child: Text(
                'PRESS',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    letterSpacing: 10.0,
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }

  Widget _buildImage() {
    return _imageFile != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0), 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(_imageFile!,
                      width: 150, height: 200, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/images/es.png',
                  width: 65,
                  color: Colors.white,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _buildCenterInfo() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildTopInfo(),
        ),
      ],
    );
  }

  Widget _buildTopInfo() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildId(),
        const SizedBox(height: 20.0),
        _buildName(),
        const SizedBox(height: 5.0),
        _buildSurname(),
        const SizedBox(height: 5.0),
        _buildIdentifier(),
        const SizedBox(height: 5.0),
        _buildNationality(),
        const SizedBox(height: 10.0),
        _buildExpiryDate(),
      ],
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text('ΔΕΛΤΙΟ ΤΑΥΤΟΤΗΤΑΣ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('INTERNATIONAL PRESS', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildId() {
    return Column(
      children: [
        Text(
          _generateId(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Αριθμός μητρώου/Card Id/Martikelnummer',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  String _generateId() {
    return '0${(Random().nextInt(900) + 100).toString()}';
  }

  double _textSize = 17.0;

  Widget _buildName() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          '${_nameGrController.text} / ${_nameEnController.text}',
          style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          width: 230.0,
          child: Divider(height: 1.0, color: Colors.black, thickness: 1.0),
        ),
        const Text(
          'Όνομα/First Name/Vorname',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  Widget _buildSurname() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          '${_surnameGrController.text} / ${_surnameEnController.text}',
          style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          width: 230.0,
          child: Divider(height: 1.0, color: Colors.black, thickness: 1.0),
        ),
        const Text(
          'Επίθετο/Name/Nachname',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  Widget _buildIdentifier() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedIdetifier,
          maxLines: 1,
          style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          width: 230.0,
          child: Divider(height: 1.0, color: Colors.black, thickness: 1.0),
        ),
        const Text(
          'Ιδιότητα/Capacity/Eigenschaft',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  Widget _buildNationality() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_ethnicityGrController.text} / ${_ethnicityEnController.text}',
          maxLines: 1,
          style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          width: 230.0,
          child: Divider(height: 1.0, color: Colors.black, thickness: 1.0),
        ),
        const Text(
          'Εθνικότητα/Nationality/Nationalität',
          style: TextStyle(fontSize: 7),
        ),
      ],
    );
  }

  Widget _buildExpiryDate() {
    return const Column(
      children: [
        Text('EXPIRAION DATE'),
        Text('30/12/2026', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

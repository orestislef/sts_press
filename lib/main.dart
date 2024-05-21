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

class _NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  Uint8List? _imageFile;
  final ScreenshotController _screenshotController = ScreenshotController();
  bool hasError = false;
  String errorText = '';

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
                  TextFormField(
                    controller: _nameController,
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
                  TextFormField(
                    controller: _surnameController,
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
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  bool isGenerating = false;

  void _generateAndDownloadCard() async {
    setState(() {
      isGenerating = true;
    });

    try {
      // Delay before taking a screenshot
      await Future.delayed(const Duration(milliseconds: 1000));

      // Capture the screenshot
      final Uint8List screenshot =
          await _screenshotController.captureFromLongWidget(
        context: context,
        constraints: BoxConstraints.tight(const Size(600, 400)),
        pixelRatio: 3.0,
        _buildBusinessCard(),
        delay: const Duration(milliseconds: 1000),
      );

      // Create a Blob from the screenshot
      final blob = html.Blob([screenshot], 'image/png');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create an anchor element and trigger a download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'press_card.png')
        ..click();

      // Revoke the object URL after download
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      errorText = e.toString();
      setState(() {
        hasError = true;
      });
      debugPrint('Error generating and downloading card: $e');
    } finally {
      setState(() {
        isGenerating = false;
      });
    }
  }

  Widget _buildBusinessCard() {
    return Container(
      height: 400,
      width: 600,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Card(
        elevation: 5,
        color: Colors.blue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Ταυτότητα Διμοσιογράφου/Journalist Identification',
              style: TextStyle(fontSize: 16, letterSpacing: 3.0),
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(_imageFile!,
                              width: 150, fit: BoxFit.scaleDown),
                        )
                      : Container(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(
                              opacity: const AlwaysStoppedAnimation(0.2),
                              fit: BoxFit.cover,
                              'https://static.wixstatic.com/media/3f1eab_d6c90136e7b14f33a143a5d9d80000fa.png/v1/fit/w_2500,h_1330,al_c/3f1eab_d6c90136e7b14f33a143a5d9d80000fa.png'),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 20),
                              Flexible(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${_nameController.text} ${_surnameController.text}',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0),
                                ),
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                'Ισχύει εώς/Valid until: 31/12/2026',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Η παρούσα κάρτα πιστοποιεί την ικανότητα του αναγραφόμενου για την άσκηση δημοσιογραφικών καθηκόντων.\nThe present card certifies the ability of the individual mentioned to exercise journalistic duties.',
                style: TextStyle(fontSize: 9, letterSpacing: 2.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

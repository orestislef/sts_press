import 'package:flutter/material.dart';

/// A widget that displays two text fields side by side for bilingual input
class BilingualTextField extends StatelessWidget {
  final TextEditingController grController;
  final TextEditingController enController;
  final String grLabel;
  final String grHint;
  final String enLabel;
  final String enHint;
  final String? Function(String?)? validator;

  const BilingualTextField({
    super.key,
    required this.grController,
    required this.enController,
    required this.grLabel,
    required this.grHint,
    required this.enLabel,
    required this.enHint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: grController,
            decoration: InputDecoration(
              labelText: grLabel,
              hintText: grHint,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            validator: validator,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(' / ', style: TextStyle(fontSize: 20)),
        ),
        Expanded(
          child: TextFormField(
            controller: enController,
            decoration: InputDecoration(
              labelText: enLabel,
              hintText: enHint,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

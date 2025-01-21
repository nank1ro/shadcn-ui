import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyStringProperty extends StatelessWidget {
  const MyStringProperty({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.hintText,
    this.inputFormatters,
  });

  final String label;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        ShadInput(
          initialValue: initialValue,
          onChanged: onChanged,
          hintText: hintText,
          inputFormatters: inputFormatters,
        )
      ],
    );
  }
}

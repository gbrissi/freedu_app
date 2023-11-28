import 'package:client/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class CreatePostTextField extends StatelessWidget {
  const CreatePostTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });
  final String hint;
  final String label;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hint: hint,
      label: label,
    );
  }
}

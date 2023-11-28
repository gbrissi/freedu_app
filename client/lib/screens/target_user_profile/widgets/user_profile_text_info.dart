import 'package:client/shared/components/custom_text_field.dart';
import 'package:client/shared/components/row_separated.dart';
import 'package:flutter/material.dart';

class UserProfileTextInfo extends StatelessWidget {
  const UserProfileTextInfo({
    super.key,
    required this.label,
    required this.text,
    required this.icon,
  });
  final String text;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 8,
      children: [
        Icon(
          icon,
        ),
        Flexible(
          child: CustomTextField(
            readOnly: true,
            maxLines: 1,
            hint: text,
            label: label,
            controller: TextEditingController(
              text: text,
            ),
          ),
        ),
      ],
    );
  }
}

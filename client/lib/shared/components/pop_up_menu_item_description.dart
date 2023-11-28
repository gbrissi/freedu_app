import 'package:client/shared/components/row_separated.dart';
import 'package:flutter/material.dart';

class PopUpMenuItemDescription extends StatelessWidget {
  const PopUpMenuItemDescription({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 12,
      children: [
        Icon(icon),
        Text(text),
      ],
    );
  }
}

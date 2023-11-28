import 'package:flutter/material.dart';

class LeadingBuilder extends StatelessWidget {
  const LeadingBuilder({
    super.key,
    required this.tooltip,
    required this.onTap,
    required this.icon,
  });
  final IconData icon;
  final void Function()? onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(99),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}

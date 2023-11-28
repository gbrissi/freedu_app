import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
  });
  final String text;
  final void Function()? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(99),
      ),
      child: Material(
        color: Theme.of(context).buttonTheme.colorScheme!.primary,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

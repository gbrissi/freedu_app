import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    this.leading,
    required this.label,
    required this.onTap,
  });
  final Widget? leading;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: IgnorePointer(
        child: leading,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

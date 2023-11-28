import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
      ),
      onPressed: onTap,
      fillColor: Theme.of(context).canvasColor,
      child: Icon(
        icon,
        size: 32,
      ),
    );
  }
}

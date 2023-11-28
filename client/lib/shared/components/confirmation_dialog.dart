import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    super.key,
    required this.dialogButton,
    required this.title,
  });
  final String title;
  final TextButton dialogButton;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  void _closeDialog() => context.pop();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
      ),
      actions: [
        TextButton(
          onPressed: _closeDialog,
          child: const Text(
            "Cancelar",
          ),
        ),
        widget.dialogButton,
      ],
    );
  }
}

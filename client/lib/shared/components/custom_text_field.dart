import 'package:flutter/material.dart';

import '../../screens/auth/widgets/auth_field/components/strength_bar/models/hide_config.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.controller,
    required this.hint,
    required this.label,
    this.hide,
    this.style,
    this.readOnly = false,
    this.validator,
  });
  final int maxLines;
  final String label;
  final HideConfig? hide;
  final String hint;
  final bool readOnly;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool value = false;

  Widget? _renderToggle() => widget.hide != null
      ? ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.hide!.onTap,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  widget.hide!.value ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
        )
      : null;

  void _rebuildField() => setState(
        () => value = !value,
      );

  @override
  void initState() {
    widget.hide?.isHidden.addListener(_rebuildField);
    super.initState();
  }

  @override
  void dispose() {
    widget.hide?.isHidden.removeListener(_rebuildField);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      readOnly: widget.readOnly,
      style: widget.style,
      obscureText: widget.hide?.value ?? false,
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffix: _renderToggle(),
      ),
      maxLines: widget.maxLines,
      controller: widget.controller,
    );
  }
}

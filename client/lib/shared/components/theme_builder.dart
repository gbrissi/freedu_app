import 'package:client/shared/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, __) {
        return Theme(
          data: provider.themeData,
          child: SafeArea(
            child: child,
          ),
        );
      },
    );
  }
}

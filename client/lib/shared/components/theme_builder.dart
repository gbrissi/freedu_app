import 'package:client/shared/providers/auth_provider.dart';
import 'package:client/shared/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  // TODO: It only triggers _init after being requested once through <read>, fix it.
  late final _authController = context.read<AuthProvider>();

  @override
  void initState() {
    print(
      "isLoggedIn, ${_authController.isLoggedIn}, ${_authController.hasSharedPrefsBeenReq}",
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, __) {
        return Theme(
          data: provider.themeData,
          child: SafeArea(
            child: widget.child,
          ),
        );
      },
    );
  }
}

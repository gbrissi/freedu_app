import 'package:client/screens/home/components/home_drawer/components/drawer_option.dart';
import 'package:client/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/auth_provider.dart';

class LoginSettingsOption extends StatefulWidget {
  const LoginSettingsOption({super.key});

  @override
  State<LoginSettingsOption> createState() => _LoginSettingsOptionState();
}

class _LoginSettingsOptionState extends State<LoginSettingsOption> {
  late final _authController = context.read<AuthProvider>();

  void _redirectToLogin() {
    context.pushNamed('login');
  }

  void _logout() {
    context.pushNamed('login');
    SharedPrefsService.clearJwtToken().then(
      (_) {
        _authController.refresh();
      },
    );
  }

  Widget _renderAuthOption(bool isLoggedIn, bool hasBeenLoaded) {
    if (hasBeenLoaded) {
      if (!isLoggedIn) {
        return DrawerOption(
          leading: const Icon(
            Icons.login,
          ),
          label: "Login",
          onTap: _redirectToLogin,
        );
      } else {
        return DrawerOption(
          leading: const Icon(
            Icons.logout,
          ),
          label: "Logout",
          onTap: _logout,
        );
      }
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, value, __) {
        return _renderAuthOption(
          value.isLoggedIn,
          value.hasSharedPrefsBeenReq,
        );
      },
    );
  }
}

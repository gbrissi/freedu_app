import 'package:client/shared/components/action_button.dart';
import 'package:client/shared/components/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/providers/auth_provider.dart';

class HomePostCreateButton extends StatefulWidget {
  const HomePostCreateButton({super.key});

  @override
  State<HomePostCreateButton> createState() => _HomePostCreateButtonState();
}

class _HomePostCreateButtonState extends State<HomePostCreateButton> {
  final bool _isEnabled = true;
  late final _authController = context.read<AuthProvider>();
  bool get isLoggedIn => _authController.isCompletelyLoggedIn;

  void _redirectToLogin() {
    context.pop();
    context.pushNamed("login");
  }

  void createPost() async {
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmationDialog(
            title: "Você deseja realizar o login para realizar essa submissão?",
            dialogButton: TextButton(
              onPressed: _redirectToLogin,
              child: const Text(
                "Confirmar",
              ),
            ),
          );
        },
      );
    } else {
      context.pushNamed(
        'createPost',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      width: 120,
      label: 'Criar nova publicação',
      icon: Icons.add,
      onTap: createPost,
      isEnabled: _isEnabled,
    );
  }
}

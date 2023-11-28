import 'package:client/screens/auth/widgets/redirect_advice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginRedirectLink extends StatefulWidget {
  const LoginRedirectLink({super.key});

  @override
  State<LoginRedirectLink> createState() => _LoginRedirectLinkState();
}

class _LoginRedirectLinkState extends State<LoginRedirectLink> {
  void _redirectToLogin() {
    context.pushNamed("login");
  }

  @override
  Widget build(BuildContext context) {
    return RedirectAdvice(
      onTap: _redirectToLogin,
      provocation: "Já tem uma conta?",
      action: "Conectar-se",
    );
  }
}

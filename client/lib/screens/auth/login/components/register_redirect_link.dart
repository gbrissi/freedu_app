import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/redirect_advice.dart';

class RegisterRedirectLink extends StatefulWidget {
  const RegisterRedirectLink({super.key});

  @override
  State<RegisterRedirectLink> createState() => _RegisterRedirectLinkState();
}

class _RegisterRedirectLinkState extends State<RegisterRedirectLink> {
  void redirectToRegister() {
    context.pushNamed(
      "register",
    );
  }

  @override
  Widget build(BuildContext context) {
    return RedirectAdvice(
      onTap: redirectToRegister,
      provocation: "Não tem uma conta?",
      action: "Cadastrar-se",
    );
  }
}

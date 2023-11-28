import 'package:flutter/material.dart';

import '../widgets/auth_scaffold.dart';
import 'components/login_form.dart';
import 'components/register_redirect_link.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScaffold(
      form: LoginForm(),
      linkToAnotherPage: RegisterRedirectLink(),
    );
  }
}

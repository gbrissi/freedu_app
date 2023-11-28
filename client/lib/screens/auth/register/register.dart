import 'package:client/screens/auth/widgets/auth_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/login_redirect_link.dart';
import 'components/register_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return const AuthScaffold(
      form: RegisterForm(),
      linkToAnotherPage: LoginRedirectLink(),
    );
  }
}

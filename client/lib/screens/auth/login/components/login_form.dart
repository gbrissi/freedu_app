import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/auth_field.dart';
import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/models/hide_config.dart';
import 'package:client/screens/auth/widgets/auth_form.dart';
import 'package:client/services/shared_prefs_service.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/http/models/http_status/implementations/http_success.dart';
import 'package:client/shared/http/repositories/auth_repository.dart';
import 'package:client/shared/providers/auth_provider.dart';
import 'package:client/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/http/models/api_result.dart';
import '../../../../shared/http/models/jwt_token.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final authController = context.read<AuthProvider>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void submit() async {
    final ApiResult<JwtToken> apiResult = await AuthRepository.passwordLogin(
      username: userController.text,
      password: passwordController.text,
    );

    if (mounted) {
      showSnackbar(
        context,
        SnackBarResult.fromApiResult(apiResult),
      );

      if (apiResult.isError) {
        passwordController.clear();
      }

      if (!apiResult.isError) {
        SharedPrefsService.storeJwtToken(
          (apiResult.result as HttpSuccess<JwtToken>).data,
        )
            .then(
              (_) => authController.refresh(),
            )
            .then(
              (_) => context.goNamed(
                "home",
              ),
            );
      }
    }
  }

  void showPasswordRecovery() {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 4,
      children: [
        Flexible(
          child: AuthForm(
            title: "Faça o seu login",
            submit: SubmitForm(
              onTap: submit,
              name: "Entrar",
            ),
            fields: <AuthField>[
              AuthField(
                controller: userController,
                hint: "Nome de usuário",
                label: "Usuário",
              ),
              AuthField(
                controller: passwordController,
                hint: "Senha do usuário",
                hide: HideConfig(),
                label: "Senha",
              ),
            ],
          ),
        ),
        InkWell(
          onTap: showPasswordRecovery,
          child: const Text(
            "Esqueci a senha",
            style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

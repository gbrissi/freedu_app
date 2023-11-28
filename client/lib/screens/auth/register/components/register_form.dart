import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/auth_field.dart';
import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/models/hide_config.dart';
import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/models/score.dart';
import 'package:client/screens/auth/widgets/auth_form.dart';
import 'package:client/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zxcvbn/zxcvbn.dart';

import '../../../../services/shared_prefs_service.dart';
import '../../../../shared/http/models/http_status/implementations/http_success.dart';
import '../../../../shared/http/models/jwt_token.dart';
import '../../../../shared/http/repositories/auth_repository.dart';
import '../../../../shared/providers/auth_provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final authController = context.read<AuthProvider>();
  final zxcvbn = Zxcvbn();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final ValueNotifier<bool> _isHidden = ValueNotifier(true);
  void _setHidden() => _isHidden.value = !_isHidden.value;
  late final HideConfig _hideConfig = HideConfig.custom(
    isHidden: _isHidden,
    onTap: _setHidden,
  );

  final Score passwordScore = Score(
    initialValue: 0,
    maxScore: 4,
  );

  void _submit() async {
    if (passwordScore.curScore.value > 2) {
      await AuthRepository.registerAccount(
        name: nameController.text,
        username: usernameController.text,
        password: passwordController.text,
      ).then((apiResult) {
        if (mounted) {
          showSnackbar(
            context,
            SnackBarResult.fromApiResult(apiResult),
          );

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
      });
    } else {
      showSnackbar(
        context,
        SnackBarResult.failure(
          "Insira uma senha com maior complexidade",
        ),
      );
    }

    if (mounted) {
      passwordController.clear();
      repeatPasswordController.clear();
    }
  }

  void _getPasswordScore() {
    final String text = passwordController.text;
    final String evaluateText = text.isNotEmpty ? text : " ";
    final Result result = zxcvbn.evaluate(evaluateText);
    final double? score = result.score;

    if (score != null) {
      passwordScore.setScore(
        score.toInt(),
      );
    }
  }

  @override
  void initState() {
    passwordController.addListener(_getPasswordScore);
    super.initState();
  }

  @override
  void dispose() {
    passwordController.removeListener(_getPasswordScore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: "Registre a sua conta",
      fields: <AuthField>[
        AuthField(
          controller: nameController,
          hint: "Nome do usuário",
          label: "Nome",
        ),
        AuthField(
          controller: usernameController,
          hint: "Nome de usuário",
          label: "Usuário",
        ),
        AuthField(
          controller: passwordController,
          hint: "Senha de usuário",
          score: passwordScore,
          label: "Senha",
          hide: _hideConfig,
        ),
        AuthField(
          controller: repeatPasswordController,
          hint: "Confirme a sua senha de usuário",
          label: "Confirmação de senha",
          hide: _hideConfig,
        ),
      ],
      submit: SubmitForm(
        onTap: _submit,
        name: "Registrar",
      ),
    );
  }
}

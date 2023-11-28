import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/models/score.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/components/custom_text_field.dart';
import '../strength_estimator.dart';
import 'models/hide_config.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.score,
    this.hide,
    this.validator,
  });
  final String label;
  final String hint;
  final Score? score;
  final String? Function(String?)? validator;
  final HideConfig? hide;
  final TextEditingController controller;

  Widget get strengthScore {
    if (score != null) {
      return StrengthEstimator(
        score: score!,
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller,
          hint: label,
          label: hint,
          hide: hide,
        ),
        strengthScore,
      ],
    );
  }
}

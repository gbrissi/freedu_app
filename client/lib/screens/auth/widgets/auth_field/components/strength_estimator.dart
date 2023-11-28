import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/components/score_bar.dart';
import 'package:client/screens/auth/widgets/auth_field/components/strength_bar/models/score.dart';
import 'package:flutter/material.dart';

class StrengthEstimator extends StatelessWidget {
  const StrengthEstimator({
    super.key,
    required this.score,
  });
  final Score score;
  bool _isActive(int index) => index < score.curScore.value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: score.curScore,
      builder: (_, __, ___) {
        return Row(
          children: List.generate(
            score.maxScore,
            (index) => Expanded(
              child: ScoreBar(
                isActive: _isActive(index),
              ),
            ),
          ),
        );
      },
    );
  }
}

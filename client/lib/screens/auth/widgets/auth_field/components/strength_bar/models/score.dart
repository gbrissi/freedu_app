import 'package:flutter/foundation.dart';

class Score {
  final ValueNotifier<int> curScore;
  final int maxScore;

  Score({
    required int initialValue,
    required this.maxScore,
  }) : curScore = ValueNotifier(initialValue);

  setScore(int score) {
    curScore.value = score;
  }
}

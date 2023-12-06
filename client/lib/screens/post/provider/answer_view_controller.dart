import 'package:client/shared/http/models/answer_model.dart';
import 'package:flutter/material.dart';

class AnswerViewController extends ChangeNotifier {
  // final ValueNotifier<List<AnswerModel>> _answers = ValueNotifier([]);
  // List<AnswerModel> get answers => _answers.value;
  // set answers(List<AnswerModel> value) => _answers.value = value;
  AnswerModel? answer;

  void addAnswer(AnswerModel value) {
    answer = value;
    notifyListeners();
  }
}

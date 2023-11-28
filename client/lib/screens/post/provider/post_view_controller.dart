import 'package:flutter/material.dart';

class PostViewController extends ChangeNotifier {
  final FocusNode _answerFocusNode = FocusNode();
  FocusNode get answerFocusNode => _answerFocusNode;
}

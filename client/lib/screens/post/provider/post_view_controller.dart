import 'package:client/shared/http/models/post_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/http/repositories/post_repository.dart';

class PostViewController extends ChangeNotifier {
  final FocusNode _answerFocusNode = FocusNode();
  FocusNode get answerFocusNode => _answerFocusNode;
  PostViewModel? _post;

  PostViewModel? get post => _post;

  void update(PostViewModel post) {
    _post = post;
    notifyListeners();
  }

  PostViewController(int postId) {
    PostRepository.getPost(postId).then((value) {
      if (!value.isError) {
        _post = value.get();
        notifyListeners();
      }
    });
  }
}

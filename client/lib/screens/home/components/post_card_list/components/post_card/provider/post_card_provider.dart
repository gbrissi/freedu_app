import 'package:client/shared/http/models/post_card_model.dart';
import 'package:flutter/material.dart';

class PostCardProvider extends ChangeNotifier {
  final PostCardModel post;

  PostCardProvider({
    required this.post,
  });
}

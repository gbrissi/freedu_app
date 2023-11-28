import 'package:client/screens/home/models/home_post_model.dart';
import 'package:client/shared/http/models/post_card_model.dart';
import 'package:flutter/material.dart';

class PostCardProvider extends ChangeNotifier {
  final PostCardModel post;

  PostCardProvider({
    required this.post,
  });
}

import 'package:client/screens/post/provider/post_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostAddComment extends StatefulWidget {
  const PostAddComment({super.key});

  @override
  State<PostAddComment> createState() => _PostAddCommentState();
}

class _PostAddCommentState extends State<PostAddComment> {
  late final postController = context.read<PostViewController>();
  void addComment() => postController.answerFocusNode.requestFocus();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.reply,
      ),
      label: const Text(
        "Responder",
      ),
      onPressed: addComment,
    );
  }
}

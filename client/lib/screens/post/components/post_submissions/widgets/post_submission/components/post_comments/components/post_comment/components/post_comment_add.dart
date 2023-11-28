import 'package:client/shared/components/quill_text_field/quill_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class PostCommentAdd extends StatefulWidget {
  const PostCommentAdd({super.key});

  @override
  State<PostCommentAdd> createState() => _PostCommentAddState();
}

class _PostCommentAddState extends State<PostCommentAdd> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: QuillTextField(
        fontSize: 14,
        controller: _controller,
        keepExpanded: false,
        maxLines: 3,
        label: "Comentário",
        placeholder: "Adicionar comentário",
      ),
    );
  }
}

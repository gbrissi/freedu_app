import 'package:client/shared/components/quill_text_field/quill_text_field.dart';
import 'package:client/shared/extensions/quill_controller_get.dart';
import 'package:client/shared/http/models/comment_model.dart';
import 'package:client/shared/http/repositories/answer_repository.dart';
import 'package:client/shared/http/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../../../../../../../utils/show_snackbar.dart';

class PostCommentAdd extends StatefulWidget {
  const PostCommentAdd({
    super.key,
    required this.targetId,
    required this.isAnswer,
    required this.onCreated,
  });
  final int targetId;
  final bool isAnswer;
  final void Function(CommentModel comment) onCreated;

  @override
  State<PostCommentAdd> createState() => _PostCommentAddState();
}

class _PostCommentAddState extends State<PostCommentAdd> {
  final QuillController _textController = QuillController.basic();

  bool _isEnabled = true;
  set isEnabled(bool value) => setState(() => _isEnabled = value);
  bool get isEnabled => _isEnabled;

  Future<void> sendPostComment() async {
    isEnabled = false;

    final result = !widget.isAnswer
        ? await PostRepository.sendComment(
            answer: _textController.get(),
            postId: widget.targetId,
          )
        : await AnswerRepository.sendComment(
            answer: _textController.get(),
            answerId: widget.targetId,
          );

    if (mounted) {
      showSnackbar(
        context,
        SnackBarResult.fromApiResult(result),
      );

      if (!result.isError) {
        widget.onCreated(
          result.get(),
        );

        _textController.clear();
      }
    }

    isEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: QuillTextField(
        fontSize: 14,
        controller: _textController,
        keepExpanded: false,
        maxLines: 3,
        label: "Comentário",
        placeholder: "Adicionar comentário",
        customButton: TextFieldButton(
          text: "Enviar",
          icon: Icons.send,
          onTap: isEnabled ? sendPostComment : null,
        ),
      ),
    );
  }
}

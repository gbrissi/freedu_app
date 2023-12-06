
import 'package:client/screens/post/provider/post_view_controller.dart';
import 'package:client/shared/components/quill_text_field/quill_text_field.dart';
import 'package:client/shared/extensions/quill_controller_get.dart';
import 'package:client/shared/http/models/answer_model.dart';
import 'package:client/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../shared/http/models/api_result.dart';
import '../../../shared/http/repositories/post_repository.dart';

class PostAnswerBlock extends StatefulWidget {
  const PostAnswerBlock({super.key});

  @override
  State<PostAnswerBlock> createState() => _PostAnswerBlockState();
}

class _PostAnswerBlockState extends State<PostAnswerBlock> {
  late final postController = context.read<PostViewController>();
  final QuillController _controller = QuillController.basic();
  bool _isEnabled = true;

  set isEnabled(bool value) => setState(() => _isEnabled = value);
  bool get isEnabled => _isEnabled;

  void sendAnswer() async {
    isEnabled = false;

    final ApiResult<AnswerModel> result = await PostRepository.sendAnswer(
      answer: _controller.get(),
      postId: postController.post!.id,
    );

    if (mounted) {
      showSnackbar(
        context,
        SnackBarResult.fromApiResult(result),
      );
    }

    isEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: QuillTextField(
          focusNode: postController.answerFocusNode,
          controller: _controller,
          keepExpanded: false,
          label: "Resposta",
          placeholder: "Insira a sua resposta aqui.",
          customButton: TextFieldButton(
            text: "Enviar",
            icon: Icons.send,
            onTap: isEnabled ? sendAnswer : null,
          ),
        ),
      ),
    );
  }
}

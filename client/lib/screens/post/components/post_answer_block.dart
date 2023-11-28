import 'package:client/screens/post/provider/post_view_controller.dart';
import 'package:client/shared/components/quill_text_field/quill_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class PostAnswerBlock extends StatefulWidget {
  const PostAnswerBlock({super.key});

  @override
  State<PostAnswerBlock> createState() => _PostAnswerBlockState();
}

class _PostAnswerBlockState extends State<PostAnswerBlock> {
  late final postController = context.read<PostViewController>();
  final QuillController controller = QuillController.basic();

  void sendAnswer() {
    // TODO: 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: QuillTextField(
          focusNode: postController.answerFocusNode,
          controller: controller,
          keepExpanded: false,
          label: "Resposta",
          placeholder: "Insira a sua resposta aqui.",
          customButton: TextFieldButton(
            text: "Enviar",
            icon: Icons.send,
            onTap: sendAnswer,
          ),
        ),
      ),
    );
  }
}

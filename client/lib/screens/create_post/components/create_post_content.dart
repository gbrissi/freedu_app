import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../shared/components/quill_text_field/quill_text_field.dart';

class CreatePostContent extends StatefulWidget {
  const CreatePostContent({super.key});

  @override
  State<CreatePostContent> createState() => _CreatePostContentState();
}

class _CreatePostContentState extends State<CreatePostContent> {
  final QuillController quillController = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return QuillTextField(
      controller: quillController,
      label: 'Descrição',
      placeholder: "Insira aqui a descrição referente a sua questão.",
    );
  }
}

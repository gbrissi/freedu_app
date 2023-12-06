import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';

import '../../../shared/components/quill_text_field/quill_text_field.dart';
import '../providers/post_create_provider.dart';

class CreatePostContent extends StatefulWidget {
  const CreatePostContent({super.key});

  @override
  State<CreatePostContent> createState() => _CreatePostContentState();
}

class _CreatePostContentState extends State<CreatePostContent> {
  late final _controller = context.read<PostCreateProvider>();
  late final QuillController _contentController = _controller.contentController;

  @override
  Widget build(BuildContext context) {
    return QuillTextField(
      controller: _contentController,
      label: 'Descrição',
      placeholder: "Insira aqui a descrição referente a sua questão.",
    );
  }
}

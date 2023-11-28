import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_post_text_field.dart';

class CreatePostSubject extends StatefulWidget {
  const CreatePostSubject({super.key});

  @override
  State<CreatePostSubject> createState() => _CreatePostSubjectState();
}

class _CreatePostSubjectState extends State<CreatePostSubject> {
  late final controller = context.read<PostCreateProvider>();
  late final TextEditingController subjectController =
      controller.subjectController;

  @override
  Widget build(BuildContext context) {
    return CreatePostTextField(
      controller: subjectController,
      label: "Assunto",
      hint: "Insira aqui o assunto referente a sua questão.",
    );
  }
}

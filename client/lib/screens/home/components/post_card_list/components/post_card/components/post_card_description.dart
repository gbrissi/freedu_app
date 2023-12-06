import 'dart:convert';

import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class PostCardDescription extends StatefulWidget {
  const PostCardDescription({super.key});

  @override
  State<PostCardDescription> createState() => _PostCardDescriptionState();
}

class _PostCardDescriptionState extends State<PostCardDescription> {
  late final _controller = context.read<PostCardProvider>();
  String get description => _controller.post.content;
  final QuillController _quillController = QuillController.basic();

  @override
  void initState() {
    super.initState();
    if (description.trim().isNotEmpty) {
      _quillController.document = Document.fromJson(jsonDecode(description));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: QuillEditor(
        controller: _quillController,
        readOnly: true,
        autoFocus: false,
        expands: false,
        focusNode: FocusNode(),
        scrollController: ScrollController(),
        scrollable: false,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../../../../shared/components/quill_data_text.dart';

class PostViewContent extends StatelessWidget {
  const PostViewContent({
    super.key,
    required this.content,
    required this.isLoading,
  });
  final String? content;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return QuillDataText.content(
      content,
      isLoading: isLoading,
    );
  }
}

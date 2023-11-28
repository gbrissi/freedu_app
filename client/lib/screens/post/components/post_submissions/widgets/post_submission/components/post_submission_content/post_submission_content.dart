import 'package:flutter/material.dart';

import 'components/post_view_content.dart';
import 'components/post_view_title.dart';

class PostSubmissionContent extends StatelessWidget {
  const PostSubmissionContent({
    super.key,
    this.title,
    required this.description,
  });
  final String? title;
  final String description;

  bool get _isTitleNull => title == null;

  Widget _renderTitle() => !_isTitleNull
      ? Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PostViewTitle(
            title: title!,
          ),
        )
      : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderTitle(),
        PostViewContent(
          text: description,
        ),
      ],
    );
  }
}

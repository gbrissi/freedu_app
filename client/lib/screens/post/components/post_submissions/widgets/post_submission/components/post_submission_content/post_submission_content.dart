import 'package:flutter/material.dart';

import 'components/post_view_content.dart';
import 'components/post_view_title.dart';

class PostSubmissionTitleConfig {
  final bool useTitle;
  final String? value;

  PostSubmissionTitleConfig({
    required this.useTitle,
    this.value,
  });
}

class PostSubmissionContent extends StatelessWidget {
  const PostSubmissionContent({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.description,
  });
  final PostSubmissionTitleConfig title;
  final String? description;
  final bool isLoading;

  Widget _renderTitle() => title.useTitle
      ? Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: PostViewTitle(
            title: title.value,
            isLoading: isLoading,
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
          content: description,
          isLoading: isLoading,
        )
      ],
    );
  }
}

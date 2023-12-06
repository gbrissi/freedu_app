import 'package:flutter/material.dart';

import 'components/post_comment_count.dart';

class PostSubmissionCommentSection extends StatelessWidget {
  const PostSubmissionCommentSection({
    super.key,
    required this.count,
    this.extra,
  });
  final int count;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        extra ?? const SizedBox.shrink(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: PostCommentCount(
              count: count,
            ),
          ),
        ),
      ],
    );
  }
}

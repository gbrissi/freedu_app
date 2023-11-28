import 'package:flutter/material.dart';

import '../../../../../../shared/components/column_separated.dart';
import 'components/post_comments/post_comments.dart';
import 'components/post_submission_comment_section/post_submission_comment_section.dart';
import 'components/post_submission_content/post_submission_content.dart';
import 'components/post_submission_header/post_submission_header.dart';

class PostSubmission extends StatelessWidget {
  const PostSubmission({
    super.key,
    required this.header,
    required this.content,
    required this.comments,
    this.extra,
  });
  final PostSubmissionHeader header;
  final PostSubmissionContent content;
  final List<String> comments;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ColumnSeparated(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                header,
                ColumnSeparated(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    content,
                    PostSubmissionCommentSection(
                      count: comments.length,
                      extra: extra,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        PostComments(
          posts: comments,
        ),
      ],
    );
  }
}

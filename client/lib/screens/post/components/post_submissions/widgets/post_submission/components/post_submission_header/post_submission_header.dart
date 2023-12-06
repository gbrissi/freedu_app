import 'package:flutter/material.dart';

import '../../../../../../../../shared/components/avatar.dart';
import '../../../../../../widgets/vote_interactive/vote_interactive.dart';
import 'components/post_author_name.dart';
import 'components/post_view_meta.dart';

class PostSubmissionHeader extends StatelessWidget {
  const PostSubmissionHeader({
    super.key,
    required this.author,
    required this.createdAt,
    this.postTags,
    required this.voteInteractive,
    required this.authorImageUrl,
  });
  final String author;
  final VoteInteractive voteInteractive;
  final DateTime createdAt;
  final List<String>? postTags;
  final String? authorImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          url: authorImageUrl,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostAuthorName(
                  name: author,
                ),
                PostViewMeta(
                  createdAt: createdAt,
                  tags: postTags ?? [],
                ),
              ],
            ),
          ),
        ),
        voteInteractive,
      ],
    );
  }
}

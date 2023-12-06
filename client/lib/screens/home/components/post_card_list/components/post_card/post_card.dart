import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/http/models/post_card_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'components/post_card_author_meta/post_card_author_meta.dart';
import 'components/post_card_description.dart';
import 'components/post_card_meta/post_card_meta.dart';
import 'components/post_card_tags/post_card_tags.dart';
import 'components/post_card_title.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final PostCardModel post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  void viewPost() => context.pushNamed(
        'post',
        extra: widget.post.id,
      );

  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostCardProvider(
        post: widget.post,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: viewPost,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ColumnSeparated(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    PostCardMeta(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostCardTitle(),
                        PostCardDescription(),
                      ],
                    ),
                    PostCardTags(),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: PostCardAuthorMeta(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

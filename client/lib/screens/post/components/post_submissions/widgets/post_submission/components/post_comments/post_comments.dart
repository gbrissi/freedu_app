import 'package:flutter/material.dart';
import 'components/post_comment/components/post_comment_add.dart';
import 'components/post_comment/components/post_comment_load_more.dart';
import 'components/post_comment/models/comment.dart';
import 'components/post_comment/post_comment.dart';

class PostComments extends StatelessWidget {
  const PostComments({
    super.key,
    required this.posts,
  });
  final List<String> posts;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: posts.length,
            (context, index) => PostComment(
              comment: Comment(
                author: "user123",
                votes: 2,
                message: "Testando o envio de uma longa mensagem longa.",
                createdAt: DateTime.now(),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: PostCommentLoadMore(),
              ),
              PostCommentAdd(),
            ],
          ),
        )
      ],
    );
  }
}

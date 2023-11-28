import 'package:client/screens/post/widgets/vote_interactive/vote_interactive.dart';
import 'package:client/shared/components/row_separated.dart';
import 'package:flutter/material.dart';
import 'components/post_comment_author.dart';
import 'components/post_comment_created_at.dart';
import 'components/post_comment_message.dart';
import 'models/comment.dart';

class PostComment extends StatelessWidget {
  const PostComment({
    super.key,
    required this.comment,
  });
  final Comment comment;

  List<InlineSpan> _getSeparatedChildren({
    required double spacing,
    required List<InlineSpan> children,
  }) {
    List<InlineSpan> separatedChildren = [];

    for (var i = 0; i < children.length; i++) {
      separatedChildren.add(children[i]);
      if (i != children.length - 1) {
        separatedChildren.add(
          WidgetSpan(
            child: SizedBox(
              width: spacing,
            ),
          ),
        );
      }
    }

    return separatedChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(4),
      )),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: RowSeparated(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VoteInteractive(
              vote: comment.votes,
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: _getSeparatedChildren(
                    spacing: 4,
                    children: [
                      // postCommentVote(
                      //   count: comment.votes,
                      // ),
                      postCommentMessage(
                        message: comment.message,
                      ),
                      postCommentAuthor(
                        context: context,
                        author: comment.author,
                      ),
                      postCommentCreatedAt(
                        context: context,
                        createdAt: comment.createdAt,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

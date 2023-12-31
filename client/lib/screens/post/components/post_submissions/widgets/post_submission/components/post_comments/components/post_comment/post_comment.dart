import 'dart:convert';

import 'package:client/screens/post/widgets/vote_interactive/vote_interactive.dart';
import 'package:client/shared/components/row_separated.dart';
import 'package:client/shared/http/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:go_router/go_router.dart';
import 'components/post_comment_author.dart';
import 'components/post_comment_created_at.dart';
import 'components/post_comment_message.dart';

enum CommentType {
  answer,
  post,
}

class PostComment extends StatefulWidget {
  const PostComment({
    super.key,
    required this.comment,
    required this.type,
  });
  final CommentModel comment;
  final CommentType type;

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  final QuillController _quillController = QuillController.basic();
  late CommentModel comment = widget.comment;

  void _updateComment(CommentModel value) {
    setState(() {
      comment = value;
    });
  }

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
  void initState() {
    _quillController.document = Document.fromJson(
      jsonDecode(comment.content),
    );

    super.initState();
  }

    void viewUserProfile() {
      context.pushNamed(
        "userProfile",
        extra: comment.author.id,
      );
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
            VoteInteractive<CommentModel>.fromVoteModel(
              onChanged: _updateComment,
              votes: comment.votes ?? [],
              target: VoteTargetConfig(
                type: widget.type == CommentType.answer
                    ? VoteTarget.answerComment
                    : VoteTarget.postComment,
                id: comment.id,
              ),
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
                        controller: _quillController,
                        message: comment.content,
                      ),
                      postCommentAuthor(
                        context: context,
                        author: comment.author.name,
                        onTap: viewUserProfile,
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

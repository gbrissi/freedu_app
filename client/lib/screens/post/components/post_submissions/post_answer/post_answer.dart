import 'package:client/screens/post/components/post_submissions/widgets/post_submission/components/post_submission_content/post_submission_content.dart';
import 'package:client/screens/post/components/post_submissions/widgets/post_submission/components/post_submission_header/post_submission_header.dart';
import 'package:client/screens/post/components/post_submissions/widgets/post_submission/post_submission.dart';
import 'package:client/screens/post/widgets/vote_interactive/vote_interactive.dart';
import 'package:client/shared/http/models/answer_model.dart';
import 'package:flutter/material.dart';

class PostAnswer extends StatelessWidget {
  const PostAnswer({
    super.key,
    required this.answer,
  });
  final AnswerModel answer;

  @override
  Widget build(BuildContext context) {
    return PostSubmission(
      meta: PostSubmissionMetadata(
        commentsCount: answer.commentsCount,
        targetId: answer.id,
        isAnswer: true,
      ),
      header: PostSubmissionHeader(
        voteInteractive: VoteInteractive.fromVoteModel(
          target: VoteTargetConfig(
            type: VoteTarget.answer,
            id: answer.id,
          ),
          votes: answer.votes ?? [],
        ),
        author: answer.author.name,
        createdAt: answer.createdAt,
        authorImageUrl: answer.author.picture,
      ),
      content: PostSubmissionContent(
        title: PostSubmissionTitleConfig(useTitle: false),
        description: answer.content,
      ),
    );
  }
}

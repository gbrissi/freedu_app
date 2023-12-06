import 'package:client/screens/post/widgets/vote_interactive/components/vote_arrow.dart';
import 'package:client/shared/http/repositories/answer_repository.dart';
import 'package:flutter/material.dart';

import '../../../../shared/http/models/vote_model.dart';
import '../../../../shared/http/repositories/post_repository.dart';
import '../../../../utils/calc_votes.dart';

enum VoteTarget {
  postComment,
  answerComment,
  answer,
  post,
}

class VoteTargetConfig {
  final VoteTarget type;
  final int? id;

  VoteTargetConfig({
    required this.type,
    required this.id,
  });
}

class VoteInteractive extends StatelessWidget {
  const VoteInteractive({
    super.key,
    required this.vote,
    required this.target,
  });
  final int vote;
  final VoteTargetConfig target;

  VoteInteractive.fromVoteModel({
    super.key,
    required this.target,
    required List<VoteModel> votes,
  }) : vote = calcVotes(votes);

  void voteFunc(bool value) {
    if (target.id != null) {
      print('O ALVO É: ${target.type}');

      if (target.type == VoteTarget.answer) {
        AnswerRepository.voteAnswer(
          target: target.id!,
          vote: value,
        );
      } else if (target.type == VoteTarget.post) {
        PostRepository.votePost(
          target: target.id!,
          vote: value,
        );
      } else if (target.type == VoteTarget.postComment) {
        PostRepository.votePostComment(
          target: target.id!,
          vote: value,
        );
      } else {
        AnswerRepository.voteAnswerComment(
          target: target.id!,
          vote: value,
        );
      }
    }
  }

  void upvote() => voteFunc(true);
  void downvote() => voteFunc(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VoteArrow(
          onTap: upvote,
          direction: ArrowDirection.up,
        ),
        Text(
          vote.toString(),
        ),
        VoteArrow(
          onTap: downvote,
          direction: ArrowDirection.down,
        ),
      ],
    );
  }
}

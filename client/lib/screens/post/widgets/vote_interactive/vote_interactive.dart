import 'package:client/screens/post/widgets/vote_interactive/components/vote_arrow.dart';
import 'package:client/shared/http/repositories/answer_repository.dart';
import 'package:flutter/material.dart';

import '../../../../shared/http/models/api_result.dart';
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

class VoteInteractive<T> extends StatelessWidget {
  const VoteInteractive({
    super.key,
    required this.vote,
    required this.target,
    required this.onChanged,
  });
  final int vote;
  final VoteTargetConfig target;
  final void Function(T value) onChanged;

  VoteInteractive.fromVoteModel({
    super.key,
    required this.target,
    required List<VoteModel> votes,
    required this.onChanged,
  }) : vote = calcVotes(votes);

  void voteFunc(bool value) async {
    if (target.id != null) {
      late ApiResult<T> result;

      if (target.type == VoteTarget.answer) {
        result = await AnswerRepository.voteAnswer(
          target: target.id!,
          vote: value,
        ) as ApiResult<T>;
      } else if (target.type == VoteTarget.post) {
        result = await PostRepository.votePost(
          target: target.id!,
          vote: value,
        ) as ApiResult<T>;
      } else if (target.type == VoteTarget.postComment) {
        result = await PostRepository.votePostComment(
          target: target.id!,
          vote: value,
        ) as ApiResult<T>;
      } else {
        result = await AnswerRepository.voteAnswerComment(
          target: target.id!,
          vote: value,
        ) as ApiResult<T>;
      }

      if (!result.isError) {
        onChanged(
          result.get(),
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

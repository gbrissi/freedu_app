import 'package:client/screens/post/widgets/vote_interactive/components/vote_arrow.dart';
import 'package:flutter/material.dart';

class VoteInteractive extends StatelessWidget {
  const VoteInteractive({
    super.key,
    required this.vote,
  });
  final int vote;

  void upvote() {
    // TODO
  }

  void downvote() {
    // TODO
  }

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

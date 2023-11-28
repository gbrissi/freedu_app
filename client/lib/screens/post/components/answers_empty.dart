import 'package:client/screens/post/components/post_submissions/post_question/components/post_add_comment.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnswersEmpty extends StatelessWidget {
  const AnswersEmpty({super.key});

  void reply() {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 12,
      children: [
        CircleAvatar(
          radius: 120,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "assets/empty.svg",
            ),
          ),
        ),
        const Text(
          "Não há nenhuma resposta para essa questão.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const PostAddComment(),
      ],
    );
  }
}

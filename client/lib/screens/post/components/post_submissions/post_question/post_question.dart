
import 'package:client/screens/post/components/post_submissions/post_question/components/post_add_comment.dart';
import 'package:client/utils/get_random_image_url.dart';
import 'package:flutter/material.dart';

import '../widgets/post_submission/components/post_submission_content/post_submission_content.dart';
import '../widgets/post_submission/components/post_submission_header/post_submission_header.dart';
import '../widgets/post_submission/post_submission.dart';

class PostQuestion extends StatelessWidget {
  const PostQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return PostSubmission(
      header: PostSubmissionHeader(
        author: "user123",
        postCreatedAt: DateTime.now(),
        postTags: const ["Português", "Inglês", "Francês"],
        authorImageUrl: getRandomImageUrl(),
      ),
      content: const PostSubmissionContent(
        title: 'Hakuna Matata',
        description:
            'Escrevendo um longo textão do zap para ver como seria o comportamento dentro de uma aplicação real.',
      ),
      comments: const [
        "12345",
        "23456",
      ],
      extra: const PostAddComment(),
    );
  }
}

import 'package:client/screens/post/components/post_submissions/widgets/post_submission/components/post_submission_content/post_submission_content.dart';
import 'package:client/screens/post/components/post_submissions/widgets/post_submission/components/post_submission_header/post_submission_header.dart';
import 'package:client/screens/post/components/post_submissions/widgets/post_submission/post_submission.dart';
import 'package:client/utils/get_random_image_url.dart';
import 'package:flutter/material.dart';

class PostAnswer extends StatelessWidget {
  const PostAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return PostSubmission(
      header: PostSubmissionHeader(
        author: "user123",
        postCreatedAt: DateTime.now(),
        authorImageUrl: getRandomImageUrl(),
      ),
      content: const PostSubmissionContent(
        description:
            "Aliqua magna cillum aliqua velit consequat aute incididunt tempor elit.",
      ),
      comments: const [
        "12345",
        "15192",
        "95120",
      ],
    );
  }
}

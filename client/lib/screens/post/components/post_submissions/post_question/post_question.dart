import 'package:client/screens/post/provider/post_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/http/models/post_view_model.dart';
import '../../../widgets/vote_interactive/vote_interactive.dart';
import '../widgets/post_submission/components/post_submission_content/post_submission_content.dart';
import '../widgets/post_submission/components/post_submission_header/post_submission_header.dart';
import '../widgets/post_submission/post_submission.dart';
import 'components/post_add_comment.dart';

class PostQuestion extends StatefulWidget {
  const PostQuestion({super.key});

  @override
  State<PostQuestion> createState() => _PostQuestionState();
}

class _PostQuestionState extends State<PostQuestion> {
  late final _postController = context.read<PostViewController>();

  @override
  Widget build(BuildContext context) {
    return Selector<PostViewController, PostViewModel?>(
      selector: (_, provider) => provider.post,
      builder: (_, post, __) {
        return PostSubmission(
          header: PostSubmissionHeader(
            voteInteractive: VoteInteractive<PostViewModel>.fromVoteModel(
              target: VoteTargetConfig(type: VoteTarget.post, id: post?.id),
              votes: post?.votes ?? [],
              onChanged: _postController.update,
            ),
            author: post?.author.name ?? "usuário",
            authorId: post?.author.id,
            createdAt: post?.createdAt ?? DateTime.now(),
            postTags: post?.tags.map((e) => e.name).toList(),
            authorImageUrl: post?.author.picture,
          ),
          content: PostSubmissionContent(
            isLoading: post == null,
            description: post?.content,
            title: PostSubmissionTitleConfig(
              useTitle: true,
              value: post?.subject,
            ),
          ),
          extra: const PostAddComment(),
          meta: PostSubmissionMetadata(
            isAnswer: false,
            commentsCount: post?.messagesCount ?? 0,
            targetId: post?.id,
          ),
        );
      },
    );
  }
}

import 'package:client/screens/post/components/post_submissions/post_question/post_question.dart';
import 'package:client/screens/post/provider/post_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_app_bar/custom_app_bar.dart';
import 'components/post_answer_block.dart';
import 'components/post_answers_declaration.dart';
import 'components/post_submissions/post_answer/post_answer.dart';

class Post extends StatefulWidget {
  const Post({
    super.key,
    required this.postId,
  });
  final int postId;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostViewController(),
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
        ),
        body: Scrollbar(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: CustomScrollView(
                controller: controller,
                slivers: const [
                  SliverToBoxAdapter(
                    child: PostQuestion(),
                  ),
                  // TODO: Add PagedSliverList
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostAnswersDeclaration(),
                          PostAnswer(),
                        ],
                      ),
                    ),
                    // child: Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: 24,
                    //   ),
                    //   child: AnswersEmpty(),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PostAnswerBlock(),
          ],
        ),
      ),
    );
  }
}

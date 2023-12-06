import 'package:client/screens/post/components/answers_empty.dart';
import 'package:client/screens/post/components/post_submissions/post_answer/post_answer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../helpers/paging_controller_manager.dart';
import '../../../../shared/http/models/answer_model.dart';
import '../../../../shared/http/models/page_options.dart';

import '../../../../shared/http/repositories/post_repository.dart';
import 'components/post_answers_declaration.dart';

class AnswersSection extends StatefulWidget {
  const AnswersSection({
    super.key,
    required this.postId,
  });
  final int postId;

  @override
  State<AnswersSection> createState() => _AnswersSectionState();
}

class _AnswersSectionState extends State<AnswersSection> {
  final int _limit = 10;
  final PagingController<int, AnswerModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      PagingControllerManager.fetchItems<AnswerModel>(
        limit: _limit,
        onError: (error) => _pagingController.error = error,
        future: PostRepository.getAnswers(
          postId: widget.postId,
          pageOptions: PageOptions(
            limit: _limit,
            page: pageKey,
          ),
        ),
        callback: (result) {
          if (result.isLastPage) {
            _pagingController.appendLastPage(result.items);
          } else {
            _pagingController.appendPage(result.items, pageKey + 1);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostAnswersDeclaration(),
        PagedListView(
          pagingController: _pagingController,
          shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate<AnswerModel>(
            noItemsFoundIndicatorBuilder: (context) => const AnswersEmpty(),
            itemBuilder: (_, item, __) => PostAnswer(
              answer: item,
            ),
          ),
        ),
      ],
    );
  }
}

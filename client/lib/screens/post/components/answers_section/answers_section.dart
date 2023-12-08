import 'package:client/screens/post/components/answers_empty.dart';
import 'package:client/screens/post/components/post_submissions/post_answer/post_answer.dart';
import 'package:client/screens/post/provider/answer_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

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
  late final _answerController = context.read<AnswerViewController>();
  final PagingController<int, AnswerModel> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    super.initState();

    _answerController.addListener(() {
      _pagingController.itemList = [
        ..._pagingController.itemList ?? [],
        _answerController.answer!,
      ];
    });

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
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: PagedListView(
            pagingController: _pagingController,
            shrinkWrap: true,
            builderDelegate: PagedChildBuilderDelegate<AnswerModel>(
              noItemsFoundIndicatorBuilder: (context) => const AnswersEmpty(),
              itemBuilder: (_, item, __) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PostAnswer(
                  answer: item,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

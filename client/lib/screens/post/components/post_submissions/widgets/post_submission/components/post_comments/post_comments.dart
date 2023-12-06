import 'package:client/helpers/paging_controller_manager.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/http/models/comment_model.dart';
import 'package:client/shared/http/models/page_options.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../shared/http/models/api_result.dart';
import '../../../../../../../../shared/http/repositories/answer_repository.dart';
import '../../../../../../../../shared/http/repositories/post_repository.dart';
import 'components/post_comment/components/post_comment_add.dart';
import 'components/post_comment/components/post_comment_load_more.dart';
import 'components/post_comment/post_comment.dart';

class PostComments extends StatefulWidget {
  const PostComments({
    super.key,
    required this.target,
    required this.isAnswer,
  });
  final int target;
  final bool isAnswer;

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  final int _limit = 5;
  int pageKey = 0;
  bool showLoadMoreButton = true;
  List<CommentModel> comments = [];

  void _setCommentToList(CommentModel item) {
    setState(() {
      comments = [...comments, item];
    });
  }

  void _addListToComments(List<CommentModel> items) {
    comments = [...comments, ...items];
  }

  void _fetchPage() {
    PagingControllerManager.fetchItems<CommentModel>(
      onError: (err) => debugPrint("Error --> $err"),
      limit: _limit,
      future: _getFutureCall(pageKey),
      callback: (result) {
        if (mounted) {
          if (result.isLastPage) {
            setState(() {
              _addListToComments(result.items);
              showLoadMoreButton = false;
            });
          } else {
            setState(() {
              pageKey = pageKey + 1;
              _addListToComments(result.items);
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    _fetchPage();
    super.initState();
  }

  Widget get _commentLoadMoreButton {
    if (showLoadMoreButton) {
      return PostCommentLoadMore(
        onTap: _fetchPage,
      );
    }

    return const SizedBox.shrink();
  }

  Future<ApiResult<List<CommentModel>>> _getFutureCall(int pageKey) =>
      !widget.isAnswer
          ? PostRepository.getComments(
              postId: widget.target,
              pageOptions: PageOptions(
                limit: _limit,
                page: pageKey,
              ),
            )
          : AnswerRepository.getComments(
              answerId: widget.target,
              pageOptions: PageOptions(
                limit: _limit,
                page: pageKey,
              ),
            );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverList.builder(
          itemCount: comments.length,
          itemBuilder: (_, index) => PostComment(
            comment: comments[index],
            type: widget.isAnswer ? CommentType.answer : CommentType.post,
          ),
        ),
        // PagedSliverList(
        //   shrinkWrapFirstPageIndicators: true,
        //   pagingController: _pagingController,
        //   builderDelegate: PagedChildBuilderDelegate<CommentModel>(
        //     noItemsFoundIndicatorBuilder: (context) => const SizedBox.shrink(),
        //     itemBuilder: (_, item, __) => PostComment(
        //       comment: item,
        //       type: widget.isAnswer ? CommentType.answer : CommentType.post,
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: ColumnSeparated(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _commentLoadMoreButton,
              PostCommentAdd(
                onCreated: _setCommentToList,
                targetId: widget.target,
                isAnswer: widget.isAnswer,
              ),
            ],
          ),
        )
      ],
    );
  }
}

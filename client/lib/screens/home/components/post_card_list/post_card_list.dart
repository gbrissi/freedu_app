import 'dart:math';

import 'package:client/extensions/contains_extension.dart';
import 'package:client/screens/home/components/post_card_list/components/post_card/post_card.dart';
import 'package:client/screens/home/provider/posts_filter_provider.dart';
import 'package:client/shared/http/models/http_status/implementations/http_success.dart';
import 'package:client/shared/http/models/page_options.dart';
import 'package:client/shared/http/models/post_card_model.dart';
import 'package:client/shared/http/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../../shared/http/models/api_result.dart';

class PostCardList extends StatefulWidget {
  const PostCardList({super.key});

  @override
  State<PostCardList> createState() => _PostCardListState();
}

class _PostCardListState extends State<PostCardList> {
  late final controller = context.read<PostsFilterProvider>();
  late String query = controller.query;
  final int _limit = 10;

  final PagingController<int, PostCardModel> _pagingController =
      PagingController(firstPageKey: 0);

  void _fetchPage(int pageKey) async {
      final ApiResult<List<PostCardModel>> result =
          await PostRepository.getCardsPaginated(
        pageOptions: PageOptions(limit: 3, page: pageKey),
      );

      if (result.isError) throw Error();
      final List<PostCardModel> items =
          (result.result as HttpSuccess<List<PostCardModel>>).data;

      final bool isLastPage = items.length < _limit;

      if (isLastPage) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(items, nextPageKey);
      }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    controller.addListener(() {
      if (controller.query != query && mounted) {
        setState(() {
          query = controller.query;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      shrinkWrap: true,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<PostCardModel>(
        itemBuilder: (_, item, __) => PostCard(
          post: item,
        ),
      ),
    );
  }
}

// return ListView(
//     //     shrinkWrap: true,
//     //     children: dummyModels
//     //         .where(
//     //           (post) => post.title.containsNormalized(query),
//     //         )
//     //         .map(
//     //           (e) => PostCard(
//     //             post: e,
//     //           ),
//     //         )
//     //         .toList());

// // TODO: temporary, posteriorly add infinite scroll pagination.
// final dummyModel = HomePostModel(
//   id: Random().nextInt(100).toString(),
//   author: const HomeAuthorModel(
//     picture: "https://source.unsplash.com/random",
//     name: "user123",
//   ),
//   tags: ["Português"],
//   createdAt: DateTime.now(),
//   views: 8,
//   answersCount: 1,
//   votes: 2,
//   title: "Lorem Ipsum",
//   description:
//       "Pariatur qui laboris eu veniam ullamco quis voluptate laborum do labore minim sunt.",
// );

// late final List<HomePostModel> dummyModels = [
//   dummyModel,
//   dummyModel,
// ];

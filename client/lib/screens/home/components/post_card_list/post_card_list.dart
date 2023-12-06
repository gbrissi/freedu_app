import 'package:client/helpers/paging_controller_manager.dart';
import 'package:client/screens/home/components/post_card_list/components/post_card/post_card.dart';
import 'package:client/screens/home/provider/posts_filter_provider.dart';
import 'package:client/shared/http/models/page_options.dart';
import 'package:client/shared/http/models/post_card_model.dart';
import 'package:client/shared/http/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class PostCardList extends StatefulWidget {
  const PostCardList({super.key});

  @override
  State<PostCardList> createState() => _PostCardListState();
}

class _PostCardListState extends State<PostCardList> {
  late final controller = context.read<PostsFilterProvider>();
  final int _limit = 10;

  final PagingController<int, PostCardModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      PagingControllerManager.fetchItems<PostCardModel>(
        limit: _limit,
        onError: (error) => _pagingController.error = error,
        future: PostRepository.getCardsPaginated(
          pageOptions: PageOptions(
            limit: _limit,
            page: pageKey,
            tags: controller.tags,
            dateRange: controller.dateRange,
            search: controller.query,
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

    controller.addListener(_pagingController.refresh);

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

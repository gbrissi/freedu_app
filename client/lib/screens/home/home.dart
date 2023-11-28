import 'package:client/screens/home/components/post_card_list/post_card_list.dart';
import 'package:client/screens/home/provider/posts_filter_provider.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/home_app_bar.dart';
import 'components/home_drawer/home_drawer.dart';
import 'components/home_header/home_header.dart';
import 'components/post_search/post_search.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ChangeNotifierProvider(
          create: (_) => PostsFilterProvider(),
          child: ColumnSeparated(
            spacing: 12,
            children: const [
              HomeHeader(),
              PostSearch(),
              PostCardList(),
            ],
          ),
        ),
      ),
    );
  }
}

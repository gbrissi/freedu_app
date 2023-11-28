import 'package:flutter/material.dart';

import 'components/post_search_bar.dart';
import 'components/post_search_button.dart';

class PostSearch extends StatelessWidget {
  const PostSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: PostFilterButton(),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.only(
              left: 8,
            ),
            child: PostSearchBar(),
          ),
        ),
      ],
    );
  }
}

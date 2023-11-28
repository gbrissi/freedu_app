import 'package:client/screens/home/components/post_card_list/components/post_card/components/post_card_author_meta/components/post_card_author_avatar.dart';
import 'package:flutter/material.dart';

import 'components/post_card_created_info.dart';

class PostCardAuthorMeta extends StatelessWidget {
  const PostCardAuthorMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: PostCardAuthorAvatar(),
        ),
        Flexible(
          child: PostCardCreatedInfo(),
        ),
      ],
    );
  }
}

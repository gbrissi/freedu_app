import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../shared/components/avatar.dart';

class PostCardAuthorAvatar extends StatefulWidget {
  const PostCardAuthorAvatar({super.key});

  @override
  State<PostCardAuthorAvatar> createState() => _PostCardAuthorAvatarState();
}

class _PostCardAuthorAvatarState extends State<PostCardAuthorAvatar> {
  late final controller = context.read<PostCardProvider>();
  // TODO:
  // String get avatarUrl => controller.post.author.picture;

  @override
  Widget build(BuildContext context) {
    // TODO: Add user avatar.
    return const Avatar(
      url: null,
    );
  }
}

import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/post_card_tag.dart';

class PostCardTags extends StatefulWidget {
  const PostCardTags({super.key});

  @override
  State<PostCardTags> createState() => _PostCardTagsState();
}

class _PostCardTagsState extends State<PostCardTags> {
  late final controller = context.read<PostCardProvider>();
  List<String> get tags => controller.post.tags.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: tags
          .map<Widget>(
            (tag) => PostCardTag(
              tag: tag,
            ),
          )
          .toList(),
    );
  }
}

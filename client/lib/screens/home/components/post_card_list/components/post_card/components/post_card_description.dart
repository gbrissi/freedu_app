import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCardDescription extends StatefulWidget {
  const PostCardDescription({super.key});

  @override
  State<PostCardDescription> createState() => _PostCardDescriptionState();
}

class _PostCardDescriptionState extends State<PostCardDescription> {
  late final controller = context.read<PostCardProvider>();
  String get description => controller.post.content;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
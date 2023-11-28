import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCardTitle extends StatefulWidget {
  const PostCardTitle({super.key});

  @override
  State<PostCardTitle> createState() => _PostCardTitleState();
}

class _PostCardTitleState extends State<PostCardTitle> {
  late final controller = context.read<PostCardProvider>();
  String get title => controller.post.subject;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
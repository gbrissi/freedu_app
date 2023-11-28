import 'package:client/helpers/date_manager.dart';
import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCardCreatedInfo extends StatefulWidget {
  const PostCardCreatedInfo({super.key});

  @override
  State<PostCardCreatedInfo> createState() => _PostCardCreatedInfoState();
}

class _PostCardCreatedInfoState extends State<PostCardCreatedInfo> {
  late final controller = context.read<PostCardProvider>();
  String get author => controller.post.author.name;
  DateTime get createdAt => controller.post.createdAt;
  String get text => "criado por $author em $date";
  String get date => DateManager.stringify(
        createdAt,
        showHours: true,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

import 'package:client/helpers/date_manager.dart';
import 'package:flutter/material.dart';

class PostViewMeta extends StatelessWidget {
  const PostViewMeta({
    super.key,
    required this.createdAt,
    required this.tags,
  });
  final List<String> tags;
  final DateTime createdAt;
  String get date => DateManager.stringify(
        createdAt,
        showHours: true,
      );
  String get tagsToString => tags.join(", ");

  @override
  Widget build(BuildContext context) {
    return Text(
      tagsToString.isNotEmpty ? "$date | $tagsToString" : date,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

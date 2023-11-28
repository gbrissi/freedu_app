import 'package:flutter/material.dart';

class PostAuthorName extends StatelessWidget {
  const PostAuthorName({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

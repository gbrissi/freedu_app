import 'package:flutter/material.dart';

class PostViewContent extends StatelessWidget {
  const PostViewContent({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

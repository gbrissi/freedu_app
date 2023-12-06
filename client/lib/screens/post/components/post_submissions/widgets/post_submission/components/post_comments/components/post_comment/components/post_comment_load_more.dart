import 'package:flutter/material.dart';

class PostCommentLoadMore extends StatelessWidget {
  const PostCommentLoadMore({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onTap,
        label: const Text("Carregar mais comentários"),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PostCommentLoadMore extends StatefulWidget {
  const PostCommentLoadMore({super.key});

  @override
  State<PostCommentLoadMore> createState() => _PostCommentLoadMoreState();
}

class _PostCommentLoadMoreState extends State<PostCommentLoadMore> {
  bool _isEnabled = true;
  set isEnabled(bool value) => setState(() => _isEnabled = value);

  void _loadMore() async {
    isEnabled = false;

    await Future.delayed(const Duration(seconds: 2));

    isEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: _isEnabled ? _loadMore : null,
        label: const Text("Carregar mais comentários"),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

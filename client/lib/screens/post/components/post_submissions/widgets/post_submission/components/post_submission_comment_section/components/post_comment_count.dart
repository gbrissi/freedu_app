import 'package:flutter/material.dart';

class PostCommentCount extends StatelessWidget {
  const PostCommentCount({
    super.key,
    required this.count,
  });
  final int count;

  void openComments() {

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: openComments,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.comment,
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Badge.count(
                  backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                  count: count,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

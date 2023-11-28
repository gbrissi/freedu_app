import 'package:flutter/material.dart';

class PostTagsBuilder extends StatelessWidget {
  const PostTagsBuilder({
    super.key,
    required this.description,
    required this.children,
  });
  final String description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: children.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: children,
          ),
        ],
      ),
    );
  }
}

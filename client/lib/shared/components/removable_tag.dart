import 'package:client/shared/components/tag.dart';
import 'package:flutter/material.dart';

class RemovableTag extends StatelessWidget {
  const RemovableTag({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Tag(
          padding: const EdgeInsets.fromLTRB(8, 4, 18, 4),
          text: text,
          onTap: onTap,
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Icon(
            Icons.close,
            color: Colors.grey.shade200,
            size: 8,
          ),
        )
      ],
    );
  }
}

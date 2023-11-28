import 'package:flutter/material.dart';

import '../../../../../../../../../shared/components/tag.dart';

class PostCardTag extends StatelessWidget {
  const PostCardTag({
    super.key,
    required this.tag,
  });
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Tag(
      text: tag,
    );
  }
}

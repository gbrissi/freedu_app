import 'package:flutter/material.dart';

import '../models/post_meta_data_model.dart';

class PostMetaData extends StatelessWidget {
  const PostMetaData({
    super.key,
    required this.metadata,
  });
  final PostMetaDataModel metadata;
  String get text => "${metadata.count} ${metadata.label}";

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

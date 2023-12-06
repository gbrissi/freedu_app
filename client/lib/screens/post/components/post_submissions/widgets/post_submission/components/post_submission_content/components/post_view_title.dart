import 'package:client/shared/components/data_text.dart';
import 'package:flutter/material.dart';

class PostViewTitle extends StatelessWidget {
  const PostViewTitle({
    super.key,
    required this.title,
    required this.isLoading,
  });
  final String? title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DataText.subject(
      title,
      isLoading: isLoading,
    );
  }
}

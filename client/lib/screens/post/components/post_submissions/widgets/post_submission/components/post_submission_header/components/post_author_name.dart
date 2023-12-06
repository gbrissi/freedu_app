import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostAuthorName extends StatefulWidget {
  const PostAuthorName({
    super.key,
    required this.name,
    required this.id,
  });
  final String name;
  final int? id;

  @override
  State<PostAuthorName> createState() => _PostAuthorNameState();
}

class _PostAuthorNameState extends State<PostAuthorName> {
  void viewUserProfile() {
    if (widget.id != null) {
      context.pushNamed(
        "userProfile",
        extra: widget.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewUserProfile,
      child: Text(
        widget.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

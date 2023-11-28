import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void _showAuthorProfile() {

}

TextSpan postCommentAuthor({
  required BuildContext context,
  required String author,
}) =>
    TextSpan(
      children: [
        const TextSpan(text: "- "),
        TextSpan(
          text: author,
          recognizer: TapGestureRecognizer()..onTap = _showAuthorProfile,
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        )
      ],
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );

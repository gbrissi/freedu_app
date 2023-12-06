import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

TextSpan postCommentAuthor({
  required BuildContext context,
  required String author,
  required void Function() onTap,
}) =>
    TextSpan(
      children: [
        const TextSpan(text: "- "),
        TextSpan(
          text: author,
          recognizer: TapGestureRecognizer()..onTap = onTap,
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        )
      ],
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );

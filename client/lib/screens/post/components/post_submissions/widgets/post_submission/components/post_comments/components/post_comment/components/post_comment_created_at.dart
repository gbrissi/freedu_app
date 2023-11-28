import 'package:client/helpers/date_manager.dart';
import 'package:flutter/material.dart';

String _getDate(DateTime createdAt) {
  return DateManager.stringify(
    createdAt,
    showHours: true,
  );
}

TextSpan postCommentCreatedAt(
        {required BuildContext context, required DateTime createdAt}) =>
    TextSpan(
      text: "${_getDate(createdAt)}.",
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7),
        fontWeight: FontWeight.w300,
      ),
    );

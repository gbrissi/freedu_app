import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

WidgetSpan postCommentMessage({
  required String message,
  required QuillController controller,
}) =>
    WidgetSpan(
      child: QuillEditor.basic(
        readOnly: true,
        autoFocus: false,
        expands: false,
        focusNode: FocusNode(),
        padding: EdgeInsets.zero,
        controller: controller,
      ),
    );

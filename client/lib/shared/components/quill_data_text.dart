import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shimmer/shimmer.dart';

class QuillDataText extends StatefulWidget {
  final String? delta;
  final String? placeholder;
  final bool isLoading;
  final TextStyle? style;

  const QuillDataText.content(
    this.delta, {
    super.key,
    this.isLoading = true,
    this.placeholder,
  }) : style = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );

  @override
  State<QuillDataText> createState() => _QuillDataTextState();
}

class _QuillDataTextState extends State<QuillDataText> {
  String get value => widget.delta ?? widget.placeholder ?? "Conteúdo vazio";
  final QuillController _controller = QuillController.basic();

  void setContent() {
    final String? delta = widget.delta;
    if (delta?.trim().isNotEmpty ?? false) {
      _controller.document = Document.fromJson(jsonDecode(delta!));
    }
  }

  @override
  void initState() {
    super.initState();
    setContent();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.delta != widget.delta) {
      setContent();
    }

    super.didUpdateWidget(oldWidget);
  }

  Widget _renderText() {
    final QuillEditor mainText = QuillEditor(
      controller: _controller,
      readOnly: true,
      autoFocus: false,
      expands: false,
      focusNode: FocusNode(),
      scrollController: ScrollController(),
      scrollable: false,
      padding: EdgeInsets.zero,
    );

    if (widget.isLoading) {
      final double textFontSize = widget.style!.fontSize!;
      final double tileWidth = textFontSize * 8;
      final buttonColor = Theme.of(context).buttonTheme.colorScheme!;

      return Shimmer.fromColors(
        baseColor: buttonColor.primary,
        highlightColor: buttonColor.secondary,
        child: Container(
          width: tileWidth,
          height: textFontSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(textFontSize / 2)),
            color: buttonColor.primary,
          ),
          child: mainText,
        ),
      );
    }

    return mainText;
  }

  @override
  Widget build(BuildContext context) => _renderText();
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DataText extends StatefulWidget {
  final String? text;
  final String? placeholder;
  final bool isLoading;
  final TextStyle? style;

  DataText.subject(
    this.text, {
    super.key,
    this.isLoading = true,
    Color? color,
    this.placeholder,
  }) : style = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: color,
        );

  DataText.content(
    this.text, {
    super.key,
    this.isLoading = true,
    Color? color,
    this.placeholder,
  }) : style = TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w400,
        );

  const DataText.custom(
    this.text, {
    super.key,
    this.isLoading = true,
    this.placeholder,
    required this.style,
  });

  @override
  State<DataText> createState() => _DataTextState();
}

class _DataTextState extends State<DataText> {
  String get value => widget.text ?? widget.placeholder ?? "Conteúdo vazio";

  Widget _renderText() {
    print("Valor: $value");

    final Text mainText = Text(
      value,
      style: widget.style,
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

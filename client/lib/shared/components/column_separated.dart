import 'package:flutter/material.dart';

List<Widget> _getSeparatedChildren({
  required List<Widget> children,
  required double spacing,
}) {
  final List<Widget> separatedChildren = [];

  for (var i = 0; i < children.length; i++) {
    separatedChildren.add(children[i]);
    if (i != children.length - 1) {
      separatedChildren.add(
        SizedBox(
          height: spacing,
        ),
      );
    }
  }

  return separatedChildren;
}

class ColumnSeparated extends Column {
  ColumnSeparated({
    super.key,
    required List<Widget> children,
    required double spacing,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
  }) : super(
          children: _getSeparatedChildren(
            children: children,
            spacing: spacing,
          ),
        );
}

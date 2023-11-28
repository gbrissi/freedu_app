import 'package:flutter/material.dart';

class ScoreBar extends StatefulWidget {
  const ScoreBar({
    super.key,
    required this.isActive,
  });
  final bool isActive;

  @override
  State<ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {
  Color get activeColor => Theme.of(context).buttonTheme.colorScheme!.primary;
  Color get inactiveColor => Theme.of(context).textTheme.bodyMedium!.color!;
  Color get curColor => widget.isActive ? activeColor : inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: curColor,
      height: 2,
    );
  }
}

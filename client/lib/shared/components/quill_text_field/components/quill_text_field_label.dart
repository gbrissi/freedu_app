import 'package:flutter/material.dart';

class QuillTextFieldLabel extends StatefulWidget {
  const QuillTextFieldLabel({
    super.key,
    required this.color,
    required this.isSelected,
    required this.label,
  });
  final Color? color;
  final String label;
  final bool isSelected;

  @override
  State<QuillTextFieldLabel> createState() => _QuillTextFieldLabelState();
}

class _QuillTextFieldLabelState extends State<QuillTextFieldLabel>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  Offset _getOffset(double value) => Offset(0, 2 * _animation.value);

  @override
  void initState() {
    _controller.forward();

    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (!widget.isSelected) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.translate(
          offset: _getOffset(_controller.value),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.color,
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        );
      },
    );
  }
}

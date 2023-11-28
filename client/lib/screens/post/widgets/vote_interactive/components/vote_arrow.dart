import 'package:flutter/material.dart';

enum ArrowDirection {
  down,
  up,
}

class VoteArrow extends StatelessWidget {
  const VoteArrow({
    super.key,
    required this.onTap,
    required this.direction,
  });
  final ArrowDirection direction;
  final void Function()? onTap;
  IconData get arrow =>
      direction == ArrowDirection.up ? Icons.expand_less : Icons.expand_more;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        arrow,
        size: 16,
      ),
    );
  }
}

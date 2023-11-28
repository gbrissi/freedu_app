import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
    required this.onTap,
    this.icon,
    required this.label,
    this.width,
    this.spacing = 8,
    this.color,
    this.isEnabled = true,
    this.suffix,
  });
  final bool isEnabled;
  final void Function() onTap;
  final String label;
  final Color? color;
  final double? width;
  final IconData? icon;
  final Widget? suffix;
  final double spacing;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  double get opacity => widget.isEnabled ? 1.0 : 0.7;

  Color get backgroundColor =>
      widget.color ?? Theme.of(context).buttonTheme.colorScheme!.primary;

  Widget get suffix => widget.suffix != null
      ? Padding(
          padding: EdgeInsets.only(
            left: widget.spacing,
          ),
          child: widget.suffix!,
        )
      : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(
        milliseconds: 200,
      ),
      child: SizedBox(
        width: widget.width,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(99),
          ),
          child: Material(
            color: backgroundColor,
            child: InkWell(
              onTap: widget.isEnabled ? widget.onTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: widget.spacing,
                      ),
                      child: Icon(
                        widget.icon,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    suffix,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

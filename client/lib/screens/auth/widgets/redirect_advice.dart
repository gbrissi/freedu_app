import 'package:flutter/material.dart';

class RedirectAdvice extends StatefulWidget {
  const RedirectAdvice({
    super.key,
    required this.onTap,
    required this.provocation,
    required this.action,
  });
  final String provocation;
  final String action;
  final void Function() onTap;
  static const TextStyle sharedStyle = TextStyle(
    fontSize: 16,
  );

  @override
  State<RedirectAdvice> createState() => _RedirectAdviceState();
}

class _RedirectAdviceState extends State<RedirectAdvice> {
  Color get buttonColor => Theme.of(context).buttonTheme.colorScheme!.primary;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${widget.provocation} ",
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: buttonColor,
                    width: 1,
                  ),
                ),
              ),
              child: InkWell(
                onTap: widget.onTap,
                child: Text(
                  widget.action,
                  style: RedirectAdvice.sharedStyle.copyWith(
                    color: buttonColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      style: RedirectAdvice.sharedStyle,
    );
  }
}

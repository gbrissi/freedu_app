import 'package:client/shared/components/action_button.dart';
import 'package:flutter/material.dart';

class ActionDropdownButton extends StatefulWidget {
  const ActionDropdownButton({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
  });
  final String label;
  final IconData icon;
  final List<PopupMenuEntry> items;

  @override
  State<ActionDropdownButton> createState() => _ActionDropdownButtonState();
}

class _ActionDropdownButtonState extends State<ActionDropdownButton> {
  final GlobalKey buttonKey = GlobalKey();

  void showOptions() {
    RenderBox renderBox =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: widget.items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      key: buttonKey,
      label: widget.label,
      onTap: showOptions,
      icon: widget.icon,
      spacing: 4,
      suffix: Padding(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: Icon(
          Icons.expand_more,
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}

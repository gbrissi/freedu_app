import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'leading_builder.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({
    super.key,
    required this.showMenu,
  });
  final bool showMenu;

  @override
  State<AppBarLeading> createState() => _AppBarLeadingState();
}

class _AppBarLeadingState extends State<AppBarLeading> {
  IconData get icon => widget.showMenu ? Icons.menu : Icons.arrow_back;

  String get tooltip =>
      widget.showMenu ? "Mostrar menu" : "Voltar à tela anterior";

  void Function() get onTap =>
      widget.showMenu ? Scaffold.of(context).openDrawer : context.pop;

  @override
  Widget build(BuildContext context) {
    return LeadingBuilder(
      tooltip: tooltip,
      onTap: onTap,
      icon: icon,
    );
  }
}

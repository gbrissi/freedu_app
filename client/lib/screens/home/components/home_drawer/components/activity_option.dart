import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'drawer_option.dart';

class ActivityOption extends StatefulWidget {
  const ActivityOption({super.key});

  @override
  State<ActivityOption> createState() => _ActivityOptionState();
}

class _ActivityOptionState extends State<ActivityOption> {
  void showActivityPage() => context.pushNamed("activity");

  @override
  Widget build(BuildContext context) {
    return DrawerOption(
      label: "Atividades",
      onTap: showActivityPage,
      leading: const Icon(
        Icons.notifications,
      ),
    );
  }
}

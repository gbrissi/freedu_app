import 'package:client/shared/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_option.dart';

class ChangeThemeOption extends StatefulWidget {
  const ChangeThemeOption({super.key});

  @override
  State<ChangeThemeOption> createState() => _ChangeThemeOptionState();
}

class _ChangeThemeOptionState extends State<ChangeThemeOption> {
  late final controller = context.read<ThemeProvider>();
  late bool state = controller.isDark;
  void changeTheme() => controller.setThemeFromBool(!state);

  @override
  void initState() {
    controller.addListener(() {
      if (state != controller.isDark && mounted) {
        setState(() {
          state = controller.isDark;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerOption(
      leading: Switch(
        value: state,
        onChanged: (_) {},
      ),
      label: "Modo escuro",
      onTap: changeTheme,
    );
  }
}

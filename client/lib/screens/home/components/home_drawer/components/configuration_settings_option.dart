import 'package:client/screens/home/components/home_drawer/components/drawer_option.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfigurationSettingsOption extends StatefulWidget {
  const ConfigurationSettingsOption({super.key});

  @override
  State<ConfigurationSettingsOption> createState() => _OptionsState();
}

class _OptionsState extends State<ConfigurationSettingsOption> {
  void showConfigurationPage() {
    context.pop();
    context.pushNamed("settings");
  }

  @override
  Widget build(BuildContext context) {
    return DrawerOption(
      label: "Configurações",
      onTap: showConfigurationPage,
      leading: const Icon(
        Icons.settings,
      ),
    );
  }
}

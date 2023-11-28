import 'package:client/screens/home/components/home_drawer/components/change_theme_option.dart';
import 'package:client/screens/home/components/home_drawer/components/drawer_user_info/drawer_user_info.dart';
import 'package:flutter/material.dart';

import 'components/activity_option.dart';
import 'components/configuration_settings_option.dart';
import 'components/home_option.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      semanticLabel: "Menu de navegação",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 24,
            ),
            child: DrawerUserData(),
          ),
          HomeOption(),
          ActivityOption(),
          ConfigurationSettingsOption(),
          Spacer(),
          ChangeThemeOption(),
        ],
      ),
    );
  }
}

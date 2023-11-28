import 'package:client/screens/home/components/home_drawer/components/change_theme_option.dart';
import 'package:client/screens/home/components/home_drawer/home_drawer.dart';
import 'package:client/screens/settings/components/edit_profile_option.dart';
import 'package:client/screens/settings/components/settings_app_bar.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';

import 'components/login_settings_option.dart';
import 'components/settings_description.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      drawer: const HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ColumnSeparated(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            const SettingsDescription(),
            ColumnSeparated(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginSettingsOption(),
                EditProfileOption(),
                ChangeThemeOption(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

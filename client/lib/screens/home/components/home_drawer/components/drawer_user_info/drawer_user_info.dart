import 'package:client/screens/home/components/home_drawer/components/drawer_user_info/components/drawer_user_avatar.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'components/drawer_user_email.dart';
import 'components/drawer_user_name.dart';

class DrawerUserData extends StatelessWidget {
  const DrawerUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
            color: Theme.of(context).colorScheme.primary,
            child: ColumnSeparated(
              spacing: 12,
              children: const [
                DrawerUserAvatar(),
                Column(
                  children: [
                    DrawerUserName(),
                    DrawerUserEmail(),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

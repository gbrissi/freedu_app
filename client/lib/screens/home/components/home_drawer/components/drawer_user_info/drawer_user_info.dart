import 'package:client/screens/home/components/home_drawer/components/drawer_user_info/components/drawer_user_avatar.dart';
import 'package:client/screens/user_profile/controller/user_profile_controller.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/providers/auth_provider.dart';
import 'components/drawer_user_email.dart';
import 'components/drawer_user_name.dart';

class DrawerUserData extends StatefulWidget {
  const DrawerUserData({super.key});

  @override
  State<DrawerUserData> createState() => _DrawerUserDataState();
}

class _DrawerUserDataState extends State<DrawerUserData> {
  late final _authController = context.read<AuthProvider>(); 
  bool get isLoggedIn => _authController.isLoggedIn;

  Widget _renderUserInfo(constraints) => isLoggedIn ? Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
            color: Theme.of(context).colorScheme.primary,
            child: ChangeNotifierProvider(
              create: (_) => UserProfileController(),
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
            ),
          ) : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _renderUserInfo(constraints);
        },
      ),
    );
  }
}

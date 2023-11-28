import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/auth_provider.dart';
import '../../home/components/home_drawer/components/drawer_option.dart';

class EditProfileOption extends StatefulWidget {
  const EditProfileOption({super.key});

  @override
  State<EditProfileOption> createState() => _EditProfileOptionState();
}

class _EditProfileOptionState extends State<EditProfileOption> {
  void editProfile() => context.pushNamed('editProfile');

  Widget _renderAuthOption(bool isLoggedIn, bool hasBeenReq) {
    if (hasBeenReq && isLoggedIn) {
      return DrawerOption(
        leading: const Icon(Icons.person),
        label: "Editar perfil",
        onTap: editProfile,
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, value, __) {
      return _renderAuthOption(
        value.isLoggedIn,
        value.hasSharedPrefsBeenReq,
      );
    });
  }
}

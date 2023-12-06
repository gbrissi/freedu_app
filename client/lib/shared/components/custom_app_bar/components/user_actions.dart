import 'package:client/shared/components/avatar.dart';
import 'package:client/shared/components/pop_up_menu_item_description.dart';
import 'package:client/utils/get_random_image_url.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserActions extends StatefulWidget {
  const UserActions({super.key});

  @override
  State<UserActions> createState() => _UserActionsState();
}

class _UserActionsState extends State<UserActions> {
  void showProfile() => context.pushNamed("userProfile");

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            onTap: showProfile,
            child: const PopUpMenuItemDescription(
              icon: Icons.person,
              text: "Perfil",
            ),
          ),
        ];
      },
      child: Avatar(
        // TODO: Add user image url.
        url: null,
      ),
    );
  }
}

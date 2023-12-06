import 'package:client/shared/components/avatar.dart';
import 'package:client/shared/components/pop_up_menu_item_description.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../services/shared_prefs_service.dart';
import '../../../http/models/jwt_token.dart';

class UserActions extends StatefulWidget {
  const UserActions({super.key});

  @override
  State<UserActions> createState() => _UserActionsState();
}

class _UserActionsState extends State<UserActions> {
  Future<void> showProfile() async {
    final JwtToken? token = await SharedPrefsService.getJwtToken();

    if (token != null) {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(
        token.accessToken,
      );

      final int tokenId = decodedToken["id"];

      if (mounted) {
        context.pushNamed(
          "userProfile",
          extra: tokenId,
        );
      }
    }
  }

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
      child: const Avatar(
        // TODO: Add user image url.
        url: null,
      ),
    );
  }
}

import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
        kMinInteractiveDimension,
      );

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      showBackButton: true,
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
    );
  }
}

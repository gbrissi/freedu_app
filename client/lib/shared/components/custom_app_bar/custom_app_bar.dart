import 'package:client/shared/components/custom_app_bar/components/leading_builder.dart';
import 'package:flutter/material.dart';

import '../../../helpers/assets_manager.dart';
import 'components/app_bar_leading.dart';
import 'components/user_actions.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final LeadingBuilder? leading;
  final Color? color;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.color,
  }) : leading = null;

  const CustomAppBar.custom({
    super.key,
    required this.leading,
    this.color,
  }) : showBackButton = false;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(
        kMinInteractiveDimension,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  Color get filterColor => widget.color != null
      ? widget.color!.computeLuminance() > 0.5
          ? Colors.grey.shade900
          : Colors.grey.shade200
      : Theme.of(context).buttonTheme.colorScheme!.primary;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color ?? Theme.of(context).canvasColor,
      leading: widget.leading ??
          AppBarLeading(
            showMenu: !widget.showBackButton,
          ),
      title: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: SizedBox(
          height: kMinInteractiveDimension / 1.5,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              filterColor,
              BlendMode.modulate,
            ),
            child: Image.asset(
              AssetsManager.logo,
            ),
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: UserActions(),
        ),
      ],
    );
  }
}

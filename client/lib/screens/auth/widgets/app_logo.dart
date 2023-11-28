import 'package:flutter/material.dart';

import '../../../helpers/assets_manager.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -16,
            left: -32,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.modulate,
              ),
              child: Image.asset(
                AssetsManager.logo,
              ),
            ),
          ),
          const Text(
            "Freedu",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}

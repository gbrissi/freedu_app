import 'package:client/shared/components/avatar.dart';
import 'package:client/utils/get_random_image_url.dart';
import 'package:flutter/material.dart';

class DrawerUserAvatar extends StatelessWidget {
  const DrawerUserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      radius: 60,
      url: getRandomImageUrl(),
    );
  }
}
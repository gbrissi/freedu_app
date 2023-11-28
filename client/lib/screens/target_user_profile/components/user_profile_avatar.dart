import 'package:flutter/material.dart';

import '../../../shared/components/avatar.dart';
import '../../../utils/get_random_image_url.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      radius: 64,
      url: getRandomImageUrl(),
    );
  }
}

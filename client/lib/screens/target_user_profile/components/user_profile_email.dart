import 'package:client/screens/target_user_profile/widgets/user_profile_text_info.dart';
import 'package:flutter/material.dart';

class UserProfileEmail extends StatelessWidget {
  const UserProfileEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserProfileTextInfo(
      label: "E-mail",
      text: "user123@gmail.com",
      icon: Icons.email,
    );
  }
}

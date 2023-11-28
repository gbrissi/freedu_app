import 'package:client/screens/target_user_profile/widgets/user_profile_text_info.dart';
import 'package:flutter/material.dart';

class UserProfileTelephone extends StatelessWidget {
  const UserProfileTelephone({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserProfileTextInfo(
      label: "Telefone",
      text: "(49) 98421-1293",
      icon: Icons.call,
    );
  }
}

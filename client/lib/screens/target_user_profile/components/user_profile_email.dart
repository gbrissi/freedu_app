import 'package:client/screens/target_user_profile/controller/target_user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_profile_text_info.dart';

class UserProfileEmail extends StatelessWidget {
  const UserProfileEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TargetUserProfileProvider, String?>(
      selector: (_, provider) => provider.email,
      builder: (_, email, __) {
        return UserProfileTextInfo(
          label: "E-mail",
          text: email ?? "user123@gmail.com",
          icon: Icons.email,
        );
      },
    );
  }
}

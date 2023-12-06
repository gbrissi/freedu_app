import 'package:client/screens/target_user_profile/controller/target_user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_profile_text_info.dart';

class UserProfileDescription extends StatelessWidget {
  const UserProfileDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TargetUserProfileProvider, String?>(
      selector: (_, provider) => provider.description,
      builder: (_, description, __) {
        return UserProfileTextInfo(
          label: "Descrição",
          text: description?.isNotEmpty ?? false
              ? description!
              : "Nenhuma descrição a ser visualizada",
          icon: Icons.description,
        );
      },
    );
  }
}

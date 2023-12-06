import 'package:client/screens/target_user_profile/controller/target_user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileUsername extends StatelessWidget {
  const UserProfileUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TargetUserProfileProvider, String?>(
      selector: (_, provider) => provider.name,
      builder: (_, name, __) {
        return Text(
          name ?? "Fulano",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

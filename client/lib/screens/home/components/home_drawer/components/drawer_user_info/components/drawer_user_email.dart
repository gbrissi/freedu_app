import 'package:client/screens/user_profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../shared/components/data_text.dart';

class DrawerUserEmail extends StatefulWidget {
  const DrawerUserEmail({super.key});

  @override
  State<DrawerUserEmail> createState() => _DrawerUserEmailState();
}

class _DrawerUserEmailState extends State<DrawerUserEmail> {
  @override
  Widget build(BuildContext context) {
    return Selector<UserProfileController, String?>(
      selector: (_, provider) => provider.email,
      builder: (_, email, __) {
        return DataText.content(
          email,
          isLoading: email == null,
          color: Colors.grey.shade200,
          placeholder: "placeholder@example.com",
        );
      },
    );
  }
}

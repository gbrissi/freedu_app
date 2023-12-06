import 'package:client/screens/user_profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../shared/components/data_text.dart';

class DrawerUserName extends StatelessWidget {
  const DrawerUserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<UserProfileController, String?>(
      selector: (_, provider) => provider.name,
      builder: (_, name, __) {
        return DataText.subject(
          name,
          color: Colors.grey.shade200,
          isLoading: name == null,
          placeholder: "Usuário",
        );
      },
    );
  }
}

import 'package:client/screens/user_profile/components/user_profile_app_bar.dart';
import 'package:client/shared/components/avatar.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/utils/get_random_image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../shared/components/custom_text_field.dart';
import '../../shared/components/page_title.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  void submit() {
    // TODO :
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserProfileAppBar(),
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
              child: Avatar(
                radius: 64,
                url: getRandomImageUrl(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ColumnSeparated(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                const PageTitle(
                  text: "Atualize o seu perfil",
                ),
                CustomTextField(
                  controller: TextEditingController(),
                  hint: "Nome de usuário",
                  label: "Usuário",
                ),
                CustomTextField(
                  controller: TextEditingController(),
                  hint: "E-mail do usuário",
                  label: "E-mail",
                ),
                // CustomTextField(
                //   controller: TextEditingController(),
                //   hint: "Apelido do usuário",
                //   label: "Apelido",
                // ),
                CustomTextField(
                  controller: TextEditingController(),
                  hint: "Telefone do usuário",
                  label: "Telefone",
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submit,
        child: Icon(
          Icons.done,
        ),
      ),
    );
  }
}

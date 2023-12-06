import 'package:client/screens/user_profile/components/user_profile_app_bar.dart';
import 'package:client/screens/user_profile/controller/user_profile_controller.dart';
import 'package:client/shared/components/avatar.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/http/models/user_profile_model.dart';
import 'package:client/utils/show_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_text_field.dart';
import '../../shared/components/page_title.dart';
import '../../shared/http/models/picker_image.dart';
import '../../shared/http/repositories/user_repository.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late final _userController = context.read<UserProfileController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  PickerImage? picture;

  bool _isEnabled = true;
  set isEnabled(bool value) => setState(() => _isEnabled = value);
  bool get isEnabled => _isEnabled;

  void _initVariables() {
    final UserProfileModel? user = _userController.user;

    nameController.text = user?.name ?? nameController.text;
    emailController.text = user?.email ?? emailController.text;
    descriptionController.text =
        user?.description ?? descriptionController.text;

    setState(() {
      picture = user?.picture != null
          ? PickerImage.fromPictureModel(user!.picture!)
          : null;
    });
  }

  void _listenToUserChanges() {
    if (mounted) {
      _initVariables();
    }
  }

  @override
  void initState() {
    super.initState();

    _initVariables();
    _userController.addListener(_listenToUserChanges);
  }

  Future<void> pickImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        picture = PickerImage.fromPlatformFile(
          result.files.single,
        );
      });
    }
  }

  Future<void> submit() async {
    isEnabled = false;

    final result = await UserRepository.updateProfile(
      name: nameController.text,
      email: emailController.text,
      description: descriptionController.text,
      picture: picture,
    );

    if (mounted) {
      showSnackbar(
        context,
        SnackBarResult.fromApiResult(result),
      );
    }

    isEnabled = true;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: pickImg,
                    child: Avatar.fromImageData(
                      radius: 64,
                      img: picture?.data,
                    ),
                  ),
                ],
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
                  controller: nameController,
                  hint: "Nome do usuário",
                  label: "Nome",
                ),
                CustomTextField(
                  controller: emailController,
                  hint: "E-mail do usuário",
                  label: "E-mail",
                ),
                CustomTextField(
                  controller: descriptionController,
                  hint: "Descrição do usuário",
                  label: "Descrição",
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submit,
        child: const Icon(
          Icons.done,
        ),
      ),
    );
  }
}

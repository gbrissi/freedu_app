import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'components/user_profile_avatar.dart';
import 'components/user_profile_description.dart';
import 'components/user_profile_email.dart';
import 'components/user_profile_username.dart';
import 'controller/target_user_profile_provider.dart';

class TargetUserProfile extends StatefulWidget {
  const TargetUserProfile({
    super.key,
    required this.target,
  });
  final int target;

  @override
  State<TargetUserProfile> createState() => _TargetUserProfileState();
}

class _TargetUserProfileState extends State<TargetUserProfile> {
  void _goBack() => context.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ChangeNotifierProvider(
            create: (_) => TargetUserProfileProvider(
              target: widget.target,
            ),
            child: ColumnSeparated(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                UserProfileAvatar(),
                UserProfileUsername(),
                UserProfileEmail(),
                UserProfileDescription(),
                // UserProfileTelephone(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goBack,
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}

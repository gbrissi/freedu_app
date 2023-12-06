import 'package:flutter/material.dart';

import '../../../shared/http/models/user_profile_model.dart';
import '../../../shared/http/repositories/user_repository.dart';

class TargetUserProfileProvider extends ChangeNotifier {
  UserProfileModel? _user;

  UserProfileModel? get user => _user;
  String? get name => user?.name;
  String? get email => user?.email;
  String? get description => user?.description;

  void _getTargetProfile(int target) async {
    final result = await UserRepository.getProfile(
      userId: target,
    );

    if (!result.isError) {
      _user = result.get();
      notifyListeners();
    }
  }

  TargetUserProfileProvider({
    required int target,
  }) {
    _getTargetProfile(target);
  }
}

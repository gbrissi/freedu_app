import 'package:client/services/shared_prefs_service.dart';
import 'package:client/shared/http/models/jwt_token.dart';
import 'package:client/shared/http/models/user_profile_model.dart';
import 'package:client/shared/http/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileModel? _user;

  UserProfileModel? get user => _user;
  String? get name => user?.name;
  String? get email => user?.email;

  void getUserProfile() async {
    final JwtToken? token = await SharedPrefsService.getJwtToken();
    if (token != null) {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(
        token.accessToken,
      );

      final result = await UserRepository.getProfile(
        userId: decodedToken["id"],
      );

      if (!result.isError) {
        _user = result.get();
        notifyListeners();
      }
    }
  }

  UserProfileController() {
    getUserProfile();
  }
}

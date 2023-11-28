import 'package:client/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';

import '../http/models/jwt_token.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  bool hasSharedPrefsBeenReq = false;
  bool get isCompletelyLoggedIn => isLoggedIn && hasSharedPrefsBeenReq;

  Future<void> _init() async {
    final JwtToken? jwtToken = await SharedPrefsService.getJwtToken();
    isLoggedIn = jwtToken != null;
    hasSharedPrefsBeenReq = true;
    notifyListeners();
  }

  Future<void> refresh() async {
    hasSharedPrefsBeenReq = false;
    notifyListeners();
    await _init();
  }

  AuthProvider() {
    _init();
  }
}

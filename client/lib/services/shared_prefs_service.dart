import 'dart:convert';

import 'package:client/shared/http/models/jwt_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/providers/theme_provider.dart';

class SharedPrefsService {
  static const String themeKey = "theme";
  static const String jwtKey = "jwt";

  static Future<SharedPreferences> _getInstance() =>
      SharedPreferences.getInstance();

  static Future<void> storeThemeState(ThemeState state) async {
    final prefs = await _getInstance();

    await prefs.setString(
      themeKey,
      state.name,
    );
  }

  static Future<ThemeState?> getThemeState() async {
    ThemeState? themeState;
    final prefs = await _getInstance();

    final String? state = prefs.getString(themeKey);
    if (state != null) {
      themeState = ThemeState.values.byName(
        state,
      );
    }

    return themeState;
  }

  static Future<void> storeJwtToken(JwtToken jwtToken) async {
    final prefs = await _getInstance();

    await prefs.setString(
      jwtKey,
      jsonEncode(
        jwtToken.toJson(),
      ),
    );
  }

  static Future<bool> clearJwtToken() async {
    final prefs = await _getInstance();
    return await prefs.remove(jwtKey);
  }

  static Future<JwtToken?> getJwtToken() async {
    JwtToken? jwtToken;
    final prefs = await _getInstance();

    final String? encodedJwtToken = prefs.getString(jwtKey);
    if (encodedJwtToken != null) {
      jwtToken = JwtToken.fromJson(
        jsonDecode(
          encodedJwtToken,
        ),
      );
    }

    return jwtToken;
  }
}

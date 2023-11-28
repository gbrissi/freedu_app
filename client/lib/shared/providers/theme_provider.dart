import 'package:client/services/shared_prefs_service.dart';
import 'package:client/themes/dark_theme.dart';
import 'package:client/themes/light_theme.dart';
import 'package:flutter/material.dart';

enum ThemeState {
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {
  ThemeState _state = ThemeState.light;

  bool get isDark {
    if (_state == ThemeState.dark) {
      return true;
    } else {
      return false;
    }
  }

  ThemeData get themeData {
    if (_state == ThemeState.dark) {
      return darkCustomTheme;
    } else {
      return lightCustomTheme;
    }
  }

  void _getInitialTheme() async {
    final prefsState = await SharedPrefsService.getThemeState();
    if (prefsState != null) {
      _state = prefsState;
    }

    notifyListeners();
  }

  ThemeProvider() {
    _getInitialTheme();
  }

  void setTheme(ThemeState theme) {
    _state = theme;
    SharedPrefsService.storeThemeState(_state);
    notifyListeners();
  }

  void setThemeFromBool(bool value) {
    if (value) {
      setTheme(
        ThemeState.dark,
      );
    } else {
      setTheme(
        ThemeState.light,
      );
    }
  }
}

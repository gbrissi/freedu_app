import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _darkCustomColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurpleAccent,
  brightness: Brightness.dark,
  primary: Colors.deepPurpleAccent.shade400,
  surface: const Color(0xff1B1A1D),
);

final darkCustomTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _darkCustomColorScheme,
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(
        color: _darkCustomColorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  canvasColor: const Color(0xff1B1A1D),
  scaffoldBackgroundColor: const Color(0xff1B1A1D),
  textTheme: GoogleFonts.robotoTextTheme(
    ThemeData.dark().textTheme,
  ),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _lightCustomColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  primary: Colors.teal.shade600,
  
);

final lightCustomTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightCustomColorScheme,
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(
        color: _lightCustomColorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  textTheme: GoogleFonts.robotoTextTheme(
    ThemeData.light().textTheme,
  ),
);



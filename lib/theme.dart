import 'package:flutter/material.dart';
import 'package:profi_vypusk/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: LightColor.primary,
    accentColor: LightColor.accent,
    backgroundColor: LightColor.primary,
    scaffoldBackgroundColor: LightColor.primary,
    canvasColor: LightColor.primary,
    hintColor: LightColor.secondary,
    highlightColor: LightColor.accent,
    focusColor: LightColor.accent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: LightColor.accent,
      ),
    ),
    iconTheme: IconThemeData(
      color: LightColor.secondary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: LightColor.accent,
      unselectedItemColor: LightColor.secondary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: DarkColor.primary,
    accentColor: DarkColor.accent,
    backgroundColor: DarkColor.primary,
    scaffoldBackgroundColor: DarkColor.primary,
    canvasColor: DarkColor.primary,
    hintColor: DarkColor.secondary,
    highlightColor: DarkColor.accent,
    focusColor: DarkColor.accent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: DarkColor.accent,
      ),
    ),
    iconTheme: IconThemeData(
      color: DarkColor.secondary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: DarkColor.accent,
      unselectedItemColor: DarkColor.secondary,
    ),
    textTheme: TextTheme().apply(
      bodyColor: DarkColor.text,
      displayColor: DarkColor.text,
    ),
  );
}

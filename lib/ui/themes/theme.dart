import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/themes/colors.dart';
import 'package:profi_vypusk/helper/services/local_storage_service.dart';

class AppTheme with ChangeNotifier {
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
  );

  ThemeData _themeData;

  AppTheme() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        this._themeData = lightTheme;
      } else {
        this._themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  ThemeData getTheme() {
    return _themeData;
  }

  void changeMode() async {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      StorageManager.saveData('themeMode', 'light');
    } else {
      _themeData = darkTheme;
      StorageManager.saveData('themeMode', 'dark');
    }
    notifyListeners();
  }
}

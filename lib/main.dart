import 'package:flutter/material.dart';
import 'package:profi_vypusk/splashPage.dart';
import 'package:profi_vypusk/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROFIВЫПУСК',
      home: SplashPage(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

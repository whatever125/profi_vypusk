import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/splashPage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppTheme>(
      create: (_) => new AppTheme(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, theme, child) => MaterialApp(
        title: 'PROFIВЫПУСК',
        home: SplashPage(),
        theme: theme.initialThemeSet(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

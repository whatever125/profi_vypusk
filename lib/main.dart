import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profi_vypusk/splashPage.dart';
import 'package:profi_vypusk/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AppTheme>(
    create: (_) => new AppTheme(),
    child: MyApp(),
  ));
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
            ));
  }
}

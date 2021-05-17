import 'package:flutter/material.dart';
import 'package:profi_vypusk/ui/pages/splashPage.dart';
import 'package:profi_vypusk/ui/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ru', 'RU'),
        ],
        locale: const Locale('ru', 'RU'),
      ),
    );
  }
}

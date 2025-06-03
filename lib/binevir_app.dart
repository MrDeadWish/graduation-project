import 'package:binevir/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:binevir/router/router.dart';
import 'constants/theme_data.dart';
class BinevirApp extends StatefulWidget {
  const BinevirApp({super.key});

  @override
  State<BinevirApp> createState() => BinevirAppState();
}

class BinevirAppState extends State<BinevirApp> {
  Locale? _locale;
  ThemeMode? _themeMode;

void setLocale(Locale locale){
  setState(() {
    _locale = locale;
  });
}


void setTheme(ThemeMode theme){
  setState(() {
    _themeMode = theme;
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Binevir',
      routerConfig: appRouter,
      supportedLocales: L10n.all,
      //locale: const Locale('ru'),
      locale: _locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
   
      localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
      ],

    );
  }
}

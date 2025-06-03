import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:binevir/binevir_app.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<BinevirAppState>();

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.test)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Язык:'),
          DropdownButton<Locale>(
            value: Localizations.localeOf(context),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                appState?.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
              DropdownMenuItem(value: Locale('ru'), child: Text('Русский')),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Тема:'),
          DropdownButton<ThemeMode>(
            value: Theme.of(context).brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            onChanged: (ThemeMode? newMode) {
              if (newMode != null) {
                appState?.setTheme(newMode);
              }
            },
            items: const [
              DropdownMenuItem(value: ThemeMode.light, child: Text('Светлая')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Тёмная')),
              DropdownMenuItem(value: ThemeMode.system, child: Text('Системная')),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'binevir_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();

  // Здесь можно зарегистрировать адаптеры, например:
  // Hive.registerAdapter(MyModelAdapter());
  // await Hive.openBox('settings');

  runApp(const BinevirApp());
}

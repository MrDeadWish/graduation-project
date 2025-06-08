import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'binevir_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Регистрация внедрений сервисов
  setup();
  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox('guides');
  // Здесь можно зарегистрировать адаптеры, например:
  // Hive.registerAdapter(MyModelAdapter());
  // await Hive.openBox('settings');

  runApp(const BinevirApp());
}

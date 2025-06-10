import 'package:binevir/data/models/person.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';

import 'binevir_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Регистрация внедрений сервисов
  setup();
  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox('guides');
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox('person_box');
  await getIt<CountryRepository>().getCountriesRequested();
  await getIt<SettingsRepository>().getSettingsRequested();

  runApp(const BinevirApp());
}

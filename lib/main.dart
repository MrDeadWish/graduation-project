import 'package:binevir/data/models/person.dart';
import 'package:binevir/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'binevir_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Hive.initFlutter();
  await Hive.openBox('guides');
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox('person_box');
  await Hive.openBox('settings_box');
  runApp(const BinevirApp());
}

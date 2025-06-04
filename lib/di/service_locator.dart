import 'package:binevir/data/http/api/application.dart';
import 'package:binevir/data/http/api/calculator.dart';
import 'package:binevir/data/http/api/country.dart';
import 'package:binevir/data/http/api/guide.dart';
import 'package:binevir/data/http/api/product.dart';
import 'package:binevir/data/http/api/settings.dart';
import 'package:binevir/data/http/dio_client.dart';
import 'package:binevir/data/repository/application_repository.dart';
import 'package:binevir/data/repository/calculator_repository.dart';
import 'package:binevir/data/repository/country_repository.dart';
import 'package:binevir/data/repository/data_repository.dart';
import 'package:binevir/data/repository/guide_repository.dart';
import 'package:binevir/data/repository/product_repository.dart';
import 'package:binevir/data/repository/settings_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(CalculatorApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(CalculatorRepository(getIt.get<CalculatorApi>()));
  getIt.registerSingleton(ProductApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ProductRepository(getIt.get<ProductApi>()));
  getIt.registerSingleton(GuideApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(GuideRepository(getIt.get<GuideApi>()));
  getIt.registerSingleton(ApplicationApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ApplicationRepository(getIt.get<ApplicationApi>()));
  getIt.registerSingleton(SettingsApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SettingsRepository(getIt.get<SettingsApi>()));
  getIt.registerSingleton(CountryApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(CountryRepository(getIt.get<CountryApi>()));
  getIt.registerSingleton(DataRepository());
}

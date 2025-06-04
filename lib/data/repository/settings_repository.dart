import 'package:binevir/data/http/api/settings.dart';
import 'package:binevir/data/models/settings.dart';
import 'package:dio/dio.dart';
import '../http/dio_exeption.dart';

class SettingsRepository {
  final SettingsApi settingsApi;
  late Settings settings;

  SettingsRepository(this.settingsApi);
  Future<Settings> getSettingsRequested() async {
    try {
      final response = await settingsApi.getSettingsApi();
      settings = Settings.fromJson(response.data['result']['settings']);
      return settings;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

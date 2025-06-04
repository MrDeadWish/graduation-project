import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class SettingsApi {
  final DioClient dioClient;

  SettingsApi({required this.dioClient});

  Future<Response> getSettingsApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.settings);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

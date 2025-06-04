import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class CountryApi {
  final DioClient dioClient;

  CountryApi({required this.dioClient});

  Future<Response> getCountriesApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.countries);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

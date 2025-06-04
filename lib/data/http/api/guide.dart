import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class GuideApi {
  final DioClient dioClient;

  GuideApi({required this.dioClient});

  Future<Response> getGuidesApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.guides);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

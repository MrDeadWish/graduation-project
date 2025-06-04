import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class ApplicationApi {
  final DioClient dioClient;

  ApplicationApi({required this.dioClient});

  Future<Response> getApplicationsApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.applications);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

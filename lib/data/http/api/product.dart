import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class ProductApi {
  final DioClient dioClient;

  ProductApi({required this.dioClient});

  Future<Response> getProductApi(int id) async {
    try {
      final Response response =
          await dioClient.get('${Endpoints.products}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductsApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.products);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

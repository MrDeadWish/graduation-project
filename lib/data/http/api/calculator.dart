import 'package:binevir/data/http/dio_client.dart';
import 'package:dio/dio.dart';
import '../endpoints.dart';

class CalculatorApi {
  final DioClient dioClient;

  CalculatorApi({required this.dioClient});

  Future<Response> getFormulaA({
    required double h,
    required double l,
  }) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.calculator}/a',
        queryParameters: {
          'h': h,
          'l': l,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFormulaN({
    required double d,
    required double m,
    required double s,
  }) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.calculator}/n',
        queryParameters: {
          'd': d,
          'm': m,
          's': s,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFormulaD({
    required double a,
    required double m,
  }) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.calculator}/d',
        queryParameters: {
          'a': a,
          'm': m,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

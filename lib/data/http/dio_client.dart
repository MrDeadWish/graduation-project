import 'package:dio/dio.dart';
import 'endpoints.dart';
import 'dart:convert'; // для json.decode
import 'package:flutter/services.dart' show rootBundle; // для rootBundle.loadString


class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  
  // Future<Response> get(
  //   String url, {
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final Response response = await _dio.get(
  //       url,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

   Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      print('Ошибка при запросе $url: $e');

      final mockPath = _getMockPath(url);
      if (mockPath != null) {
        final jsonString = await rootBundle.loadString(mockPath);
        final jsonData = json.decode(jsonString);
        return Response(
          requestOptions: RequestOptions(path: url),
          data: jsonData,
          statusCode: 200,
        );
      }

      rethrow;
    }
  }

  /// Карта URL -> путь к мок-файлу
  String? _getMockPath(String url) {
    final mockMap = {
      Endpoints.countries: 'assets/mock/countries.json',
      Endpoints.products: 'assets/mock/products.json',
      Endpoints.applications: 'assets/mock/applications.json',
      Endpoints.settings: 'assets/mock/settings.json',
      Endpoints.guides: 'assets/mock/guides.json',
    };

    // Проверка на окончание URL
    for (final entry in mockMap.entries) {
      if (url.endsWith(entry.key)) {
        return entry.value;
      }
    }

    return null;
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

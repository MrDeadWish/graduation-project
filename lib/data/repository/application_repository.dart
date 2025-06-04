import 'package:binevir/data/http/api/application.dart';
import 'package:binevir/data/http/dio_exeption.dart';
import 'package:binevir/data/models/product.dart';
import 'package:dio/dio.dart';

class ApplicationRepository {
  final ApplicationApi applicationsApi;
  late List<Application> applications;

  ApplicationRepository(this.applicationsApi);

  Future<List<Application>> getApplicationsRequested() async {
    try {
      final response = await applicationsApi.getApplicationsApi();
      applications = (response.data['result']['applications'] as List)
          .map((e) => Application.fromJson(e))
          .toList();
      return applications;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

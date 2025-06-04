import 'package:binevir/data/http/api/guide.dart';
import 'package:binevir/data/models/guide.dart';
import 'package:dio/dio.dart';
import '../http/dio_exeption.dart';

class GuideRepository {
  final GuideApi guideApi;
  late List<Guide> guides;
  GuideRepository(this.guideApi);

  Future<List<Guide>> getGuideRequested() async {
    try {
      final response = await guideApi.getGuidesApi();
      final guides = (response.data['result']['guides'] as List)
          .map((e) => Guide.fromJson(e))
          .toList();
      return guides;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

import 'package:binevir/data/http/api/guide.dart';
import 'package:binevir/data/models/guide.dart';
import 'package:dio/dio.dart';
import '../http/dio_exeption.dart';
import 'package:hive/hive.dart';

class GuideRepository {
  final GuideApi guideApi;
  late List<Guide> guides;
   bool isFromCache = true;
  GuideRepository(this.guideApi, {this.isFromCache = false});

  Future<List<Guide>> getGuideRequested() async {
    try {
      final response = await guideApi.getGuidesApi();
      final guides = (response.data['result']['guides'] as List)
          .map((e) => Guide.fromJson(e))
          .toList();
          final box = await Hive.openBox('guides');
        
      await box.put('guides', guides.map((e)=>e.toJson()).toList());
      return guides;
    } on DioException catch (e) {
      final box = await Hive.openBox('guides');
      final cached = box.get('guides');
      if(cached != null && cached is List){
            return cached
            .map((e) => Guide.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

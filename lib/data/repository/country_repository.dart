import 'package:binevir/data/http/api/country.dart';
import 'package:binevir/data/http/dio_exeption.dart';
import 'package:binevir/data/models/country.dart';
import 'package:dio/dio.dart';

class CountryRepository {
  final CountryApi countriesApi;
  late List<Country> countries = [];

  CountryRepository(this.countriesApi);

  Future<List<Country>> getCountriesRequested() async {
    try {
      final response = await countriesApi.getCountriesApi();
      countries = (response.data['result']['countries'] as List)
          .map((e) => Country.fromJson(e))
          .toList();
      return countries;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

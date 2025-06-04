import 'package:binevir/data/http/api/calculator.dart';
import 'package:binevir/data/http/dio_exeption.dart';
import 'package:dio/dio.dart';

class CalculatorRepository {
  final CalculatorApi calculatorApi;
  double A = 0.0;
  double N = 0.0;
  double D = 0.0;

  CalculatorRepository(this.calculatorApi);

  Future<double> getFormulaA({
    required double h,
    required double l,
  }) async {
    try {
      final response = await calculatorApi.getFormulaA(h: h, l: l);
      A = response.data['result']['data'];
      return A;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<double> getFormulaN({
    required double d,
    required double m,
    required double s,
  }) async {
    try {
      final response = await calculatorApi.getFormulaN(
        d: d,
        m: m,
        s: s,
      );
      N = response.data['result']['data'];
      return A;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<double> getFormulaD({
    required double a,
    required double m,
  }) async {
    try {
      final response = await calculatorApi.getFormulaD(
        a: a,
        m: m,
      );
      D = response.data['result']['data'];
      return D;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

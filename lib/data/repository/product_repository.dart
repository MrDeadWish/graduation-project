import 'package:binevir/data/http/api/product.dart';
import 'package:dio/dio.dart';

import '../http/dio_exeption.dart';
import '../models/product.dart';

class ProductRepository {
  final ProductApi productApi;
  late List<Product> products;
  late Product product;

  ProductRepository(this.productApi);

  Future<Product> getProductById(int id) async {
    try {
      final response = await productApi.getProductApi(id);
      product = Product.fromJson(response.data['result']['product']);
      return product;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await productApi.getProductsApi();
      products = (response.data['result']['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return products;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

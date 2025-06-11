import 'dart:async';

import 'package:binevir/data/models/product.dart';
import 'package:binevir/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductLoad>((event, emit) async {
      try {
        if (state is! ProductLoaded) {
          emit(ProductLoading());
        }
        final product = await productRepository.getProductById(event.id);
        print('Путь до модели${product.model}');
        emit(ProductLoaded(product: product));
      } catch (e) {
        emit(ProductLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final ProductRepository productRepository;
}

import 'dart:async';
import 'package:binevir/data/models/product.dart';
import 'package:binevir/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this.productRepository) : super(CatalogInitial()) {
    on<LoadCatalog>((event, emit) async {
      try {
        if (state is! CatalogLoaded) {
          emit(CatalogLoading());
        }
        final products = await productRepository.getProducts();
        emit(CatalogLoaded(products: products));
      } catch (e) {
        emit(CatalogLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  final ProductRepository productRepository;
}

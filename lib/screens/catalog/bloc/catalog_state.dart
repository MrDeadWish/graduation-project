part of 'catalog_bloc.dart';

abstract class CatalogState {}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  CatalogLoaded({
    required this.products,
  });
  final List<Product> products;
}

class CatalogLoadingFailure extends CatalogState {
  CatalogLoadingFailure({
    required this.exception,
  });
  final Object? exception;
}

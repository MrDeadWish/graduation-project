part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  ProductLoaded({
    required this.product,
  });
  final Product product;
}

class ProductLoadingFailure extends ProductState {
  ProductLoadingFailure({
    required this.exception,
  });
  final Object? exception;
}

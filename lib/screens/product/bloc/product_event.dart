part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductLoad extends ProductEvent {
  final Completer? completer;
  final int id;

  ProductLoad({
    required this.id,
    this.completer,
  });
}

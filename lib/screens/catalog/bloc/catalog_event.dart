part of 'catalog_bloc.dart';

abstract class CatalogEvent {}

class LoadCatalog extends CatalogEvent {
  final Completer? completer;

  LoadCatalog({
    this.completer,
  });
}

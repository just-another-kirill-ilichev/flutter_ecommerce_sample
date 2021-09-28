part of 'products_bloc.dart';

abstract class ProductsEvent {}

class AppStarted extends ProductsEvent {}

class ProductsDataChanged extends ProductsEvent {
  final List<Product> products;

  ProductsDataChanged(this.products);
}

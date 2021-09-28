part of 'products_bloc.dart';

class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoadInProgress extends ProductsState {}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> products;

  ProductsLoadSuccess(this.products);
}

class ProductsLoadError extends ProductsState {
  final String errorDescription;

  ProductsLoadError(this.errorDescription);
}

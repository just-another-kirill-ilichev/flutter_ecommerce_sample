import 'package:flutter_ecommerce_sample/domain/model/product.dart';

abstract class ProductsEvent {}

class AppStarted extends ProductsEvent {}

class ProductsDataChanged extends ProductsEvent {
  final List<Product> products;

  ProductsDataChanged(this.products);
}

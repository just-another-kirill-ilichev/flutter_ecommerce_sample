import 'package:flutter_ecommerce_sample/domain/model/product.dart';

abstract class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {}

class UpdateProductsEvent extends ProductsEvent {
  final List<Product?> products;

  UpdateProductsEvent(this.products);
}

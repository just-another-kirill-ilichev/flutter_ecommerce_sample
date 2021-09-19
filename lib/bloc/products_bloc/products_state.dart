import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class ProductsState {
  final bool isLoaded;
  final List<Product> products;

  ProductsState(this.isLoaded, this.products);
}

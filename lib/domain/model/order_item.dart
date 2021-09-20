import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class OrderItem {
  final Product product;
  final int amount;

  OrderItem({
    required this.product,
    required this.amount,
  });
}

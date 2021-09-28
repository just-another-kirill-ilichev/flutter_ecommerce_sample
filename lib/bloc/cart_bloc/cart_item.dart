import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class CartItem {
  final Product product;
  final int amount;

  CartItem(this.product, this.amount);

  CartItem copyWith({
    Product? product,
    int? amount,
  }) {
    return CartItem(
      product ?? this.product,
      amount ?? this.amount,
    );
  }

  OrderItem toOrderItem() {
    return OrderItem(product.id!, amount);
  }
}

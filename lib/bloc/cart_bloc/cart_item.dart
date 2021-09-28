part of 'cart_bloc.dart';

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

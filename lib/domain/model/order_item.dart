import 'dart:convert';

import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class OrderItem {
  final Product product;
  final int amount;
  OrderItem({
    required this.product,
    required this.amount,
  });

  OrderItem copyWith({
    Product? product,
    int? amount,
  }) {
    return OrderItem(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'amount': amount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      product: Product.fromMap(map['product']),
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() => 'OrderItem(product: $product, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.product == product &&
        other.amount == amount;
  }

  @override
  int get hashCode => product.hashCode ^ amount.hashCode;
}

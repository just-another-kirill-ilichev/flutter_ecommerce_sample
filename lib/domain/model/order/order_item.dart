part of 'order.dart';

class OrderItem {
  final String productId;
  final int amount;

  OrderItem(this.productId, this.amount);

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'amount': amount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      map['productId'],
      map['amount'],
    );
  }
}

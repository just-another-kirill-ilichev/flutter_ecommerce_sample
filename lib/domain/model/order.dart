import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

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

class DeliveryInfo {
  DeliveryInfo();

  factory DeliveryInfo.fromMap(Map<String, dynamic> map) {
    return DeliveryInfo();
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}

class Order extends Entity<String> {
  final List<OrderItem> items;
  final DeliveryInfo deliveryInfo;
  final String userId;

  Order({
    String? id,
    required this.items,
    required this.deliveryInfo,
    required this.userId,
  }) : super(id);

  factory Order.fromMap(String id, Map<String, dynamic> map) {
    return Order(
      id: id,
      items: map['items']
          .cast<Map<String, dynamic>>()
          .map((e) => OrderItem.fromMap(e)),
      deliveryInfo: DeliveryInfo.fromMap(map['deliveryInfo']),
      userId: map['userId'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'deliveryInfo': deliveryInfo.toMap(),
      'userId': userId,
    };
  }
}

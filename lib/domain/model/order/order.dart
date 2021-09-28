import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

part 'order_item.dart';
part 'delivery_info.dart';
part 'order_status.dart';

class Order extends Entity<String> {
  final List<OrderItem> items;
  final DeliveryInfo deliveryInfo;
  final String userId;
  final OrderStatus status;
  final DateTime date;

  Order({
    String? id,
    required this.items,
    required this.deliveryInfo,
    required this.userId,
    required this.status,
    required this.date,
  }) : super(id);

  factory Order.fromMap(String id, Map<String, dynamic> map) {
    return Order(
      id: id,
      items: map['items']
          .cast<Map<String, dynamic>>()
          .map<OrderItem>((e) => OrderItem.fromMap(e))
          .toList(),
      deliveryInfo: DeliveryInfo.fromMap(map['deliveryInfo']),
      userId: map['userId'],
      date: map['date'].toDate(),
      status: OrderStatusExtension.parse(map['status']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'deliveryInfo': deliveryInfo.toMap(),
      'userId': userId,
      'date': date,
      'status': status.stringValue,
    };
  }
}

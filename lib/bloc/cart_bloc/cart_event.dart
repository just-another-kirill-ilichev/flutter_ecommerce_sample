import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';

abstract class CartEvent {}

class OrderItemAdded extends CartEvent {
  final OrderItem item;

  OrderItemAdded(this.item);
}

class OrderItemRemoved extends CartEvent {
  final OrderItem item;

  OrderItemRemoved(this.item);
}

class CartCleared extends CartEvent {}

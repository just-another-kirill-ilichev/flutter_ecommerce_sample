import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final OrderItem item;

  AddToCartEvent(this.item);
}

class RemoveFromCartEvent extends CartEvent {
  final OrderItem item;

  RemoveFromCartEvent(this.item);
}

class ClearCartEvent extends CartEvent {}

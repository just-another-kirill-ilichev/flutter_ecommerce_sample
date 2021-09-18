import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

abstract class CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final OrderItem item;

  AddItemToCartEvent(this.item);
}

class RemoveItemFromCartEvent extends CartEvent {
  final OrderItem item;

  RemoveItemFromCartEvent(this.item);
}

class ClearCartEvent extends CartEvent {}

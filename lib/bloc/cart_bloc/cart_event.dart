import 'package:flutter_ecommerce_sample/domain/model/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

abstract class CartEvent {}

class ItemsAdded extends CartEvent {
  final Product product;
  final int amount;

  ItemsAdded(this.product, this.amount);
}

class ItemsRemoved extends CartEvent {
  final Product product;
  final int amount;

  ItemsRemoved(this.product, this.amount);
}

class ItemsCleared extends CartEvent {}

class OrderRequested extends CartEvent {
  final DeliveryInfo deliveryInfo;

  OrderRequested(this.deliveryInfo);
}

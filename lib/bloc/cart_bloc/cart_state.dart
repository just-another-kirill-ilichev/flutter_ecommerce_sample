import 'dart:collection';

import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';

class CartState {
  final UnmodifiableListView<OrderItem> items;

  CartState(Iterable<OrderItem> items) : items = UnmodifiableListView(items);
}

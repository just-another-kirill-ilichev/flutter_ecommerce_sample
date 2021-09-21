import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(initialState) : super(initialState);

  factory CartBloc.initial() {
    return CartBloc(CartState([]));
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is ClearCartEvent) {
      yield CartState([]);
    } else if (event is AddToCartEvent) {
      yield _add(event);
    } else if (event is RemoveFromCartEvent) {
      yield _remove(event);
    }
  }

  CartState _remove(RemoveFromCartEvent event) {
    var items = state.items.toList();

    var index = items.indexWhere((e) => e.product.id == event.item.product.id);

    if (index == -1) {
      throw ArgumentError.value(event, 'event'); // TODO
    }

    var newAmount = items[index].amount - event.item.amount;

    if (newAmount < 0) {
      throw ArgumentError.value(event, 'event'); // TODO
    } else if (newAmount == 0) {
      items.removeAt(index);
    } else {
      items[index] = OrderItem(product: event.item.product, amount: newAmount);
    }

    return CartState(items);
  }

  CartState _add(AddToCartEvent event) {
    var items = state.items.toList();

    var index = items.indexWhere((e) => e.product.id == event.item.product.id);

    if (index != -1) {
      var newAmount = event.item.amount + items[index].amount;
      var newItem = OrderItem(product: event.item.product, amount: newAmount);

      items[index] = newItem;
    } else {
      items.add(event.item);
    }

    return CartState(items);
  }
}

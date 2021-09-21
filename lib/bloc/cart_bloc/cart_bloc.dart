import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
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
    var index = _getIndexByProduct(event.item.product);
    return _updateAmount(index, -event.item.amount);
  }

  CartState _add(AddToCartEvent event) {
    var index = _getIndexByProduct(event.item.product);

    if (index != -1) {
      return _updateAmount(index, event.item.amount);
    }

    return CartState(List<OrderItem>.from(state.items)..add(event.item));
  }

  int _getIndexByProduct(Product product) =>
      state.items.indexWhere((e) => e.product.id == product.id);

  CartState _updateAmount(int itemIndex, int amount) {
    assert(itemIndex >= 0);

    var items = List<OrderItem>.from(state.items);
    var newAmount = items[itemIndex].amount + amount;

    assert(newAmount >= 0);

    if (newAmount == 0) {
      items.removeAt(itemIndex);
    } else {
      items[itemIndex] = OrderItem(
        product: items[itemIndex].product,
        amount: newAmount,
      );
    }

    return CartState(items);
  }
}

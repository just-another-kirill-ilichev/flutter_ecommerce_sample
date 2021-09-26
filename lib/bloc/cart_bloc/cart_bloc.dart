import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartCleared>(_clear);
    on<OrderItemRemoved>(_remove);
    on<OrderItemAdded>(_add);
  }

  void _clear(CartCleared event, Emitter<CartState> emit) =>
      emit(CartState([]));

  void _remove(OrderItemRemoved event, Emitter<CartState> emit) {
    var index = _getIndexByProduct(event.item.product);
    emit(_updateAmount(index, -event.item.amount));
  }

  void _add(OrderItemAdded event, Emitter<CartState> emit) {
    var index = _getIndexByProduct(event.item.product);

    if (index != -1) {
      emit(_updateAmount(index, event.item.amount));
    } else {
      var newState =
          CartState(List<OrderItem>.from(state.items)..add(event.item));
      emit(newState);
    }
  }

  int _getIndexByProduct(Product product) =>
      state.items.indexWhere((e) => e.product.id == product.id);

  CartState _updateAmount(int itemIndex, int amount) {
    assert(itemIndex >= 0 && itemIndex < state.items.length);

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

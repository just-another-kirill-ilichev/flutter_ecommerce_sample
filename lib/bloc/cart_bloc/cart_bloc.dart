import 'package:bloc/bloc.dart';
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
    } else if (event is AddItemToCartEvent) {
      yield CartState(state.items..add(event.item));
    } else if (event is RemoveItemFromCartEvent) {
      yield CartState(state.items..remove(event.item));
    }
  }
}

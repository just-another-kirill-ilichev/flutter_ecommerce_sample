import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart' as auth;
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

part 'cart_item.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final auth.AuthBloc authBloc;
  final ServiceProvider serviceProvider;

  late RepositoryBase<Order, String> _repository;

  CartBloc(this.authBloc, this.serviceProvider) : super(CartState([])) {
    on<AppStarted>(_onAppStarted);
    on<ItemsCleared>(_clear);
    on<ItemsRemoved>(_remove);
    on<ItemsAdded>(_add);
    on<OrderRequested>(_onOrderRequested);
  }

  factory CartBloc.started(
      auth.AuthBloc authBloc, ServiceProvider serviceProvider) {
    return CartBloc(authBloc, serviceProvider)..add(AppStarted());
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<CartState> emit) async {
    var databaseService = await serviceProvider.databaseService;
    _repository = databaseService.orderRepository;
  }

  void _clear(ItemsCleared event, Emitter<CartState> emit) =>
      emit(CartState([]));

  void _remove(ItemsRemoved event, Emitter<CartState> emit) {
    var index = _getIndexByProduct(event.product);

    assert(index != -1);

    var newAmount = state.items[index].amount - event.amount;
    var newState = newAmount > 0
        ? _setItemAmountAt(index, newAmount)
        : _removeItemAt(index);

    emit(newState);
  }

  void _add(ItemsAdded event, Emitter<CartState> emit) {
    var index = _getIndexByProduct(event.product);
    CartState newState;

    if (index != -1) {
      var newAmount = state.items[index].amount + event.amount;
      newState = _setItemAmountAt(index, newAmount);
    } else {
      var newItem = CartItem(event.product, event.amount);
      newState = _insertItem(newItem);
    }

    emit(newState);
  }

  int _getIndexByProduct(Product product) =>
      state.items.indexWhere((e) => e.product.id == product.id);

  CartState _insertItem(CartItem item) {
    var items = List<CartItem>.from(state.items)..add(item);

    return CartState(items);
  }

  CartState _removeItemAt(int index) {
    assert(index >= 0 && index < state.items.length);

    var items = List<CartItem>.from(state.items)..removeAt(index);
    return CartState(items);
  }

  CartState _setItemAmountAt(int index, int amount) {
    assert(index >= 0 && index < state.items.length);
    assert(amount > 0);

    var items = List<CartItem>.from(state.items);

    items[index] = items[index].copyWith(amount: amount);

    return CartState(items);
  }

  Future<void> _onOrderRequested(
    OrderRequested event,
    Emitter<CartState> emit,
  ) async {
    if (authBloc.state is! auth.Authenticated) {
      return;
    }

    var currentUser = (authBloc.state as auth.Authenticated).user;
    var items = state.items.map((e) => e.toOrderItem()).toList();

    var order = Order(
      items: items,
      deliveryInfo: event.deliveryInfo,
      userId: currentUser.id!,
      status: OrderStatus.processing,
      date: DateTime.now(),
    );

    var orderId = await _repository.save(order);
    _updateUserOrders(currentUser, orderId);

    add(ItemsCleared());
  }

  void _updateUserOrders(User currentUser, String orderId) {
    var user = currentUser.copyWith(orders: currentUser.orders..add(orderId));

    authBloc.add(auth.UserDataEdited(user));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart'
    show AuthBloc, AuthState, Authenticated;
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/data_filter.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

class OrdersBloc extends CrudBloc<Order> {
  final AuthBloc authBloc;

  StreamSubscription? _authBlocSubscription;

  OrdersBloc(this.authBloc, ServiceProvider servicesProvider)
      : super(servicesProvider);

  factory OrdersBloc.started(
    AuthBloc authBloc,
    ServiceProvider servicesProvider,
  ) {
    return OrdersBloc(authBloc, servicesProvider)..add(AppStarted());
  }

  @override
  Future<void> onDataProviderInitialized(
    DataProviderInitialized<Order> event,
    Emitter<CrudState<Order>> emit,
  ) async {
    // We might miss some events if this bloc was initialized after auth bloc
    _updateData(authBloc.state);

    // It's very unlikely that we have two DataProviderInitialized events,
    // but just in case let's cancel auth bloc subscription
    _authBlocSubscription?.cancel();
    _authBlocSubscription = authBloc.stream.listen(_updateData);
  }

  void _updateData(AuthState state) {
    if (state is Authenticated) {
      add(DataGetWithFilterRequested(WithIdDataFilter(state.user.orders)));
    } else {
      add(DataGetWithFilterRequested(NoDataFilter()));
    }
  }

  @override
  Future<void> close() async {
    _authBlocSubscription?.cancel();
    return super.close();
  }
}

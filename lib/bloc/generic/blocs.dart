import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

class OrdersBloc extends CrudBloc<Order> {
  OrdersBloc(ServiceProvider servicesProvider) : super(servicesProvider);

  factory OrdersBloc.started(ServiceProvider servicesProvider) {
    return OrdersBloc(servicesProvider)..add(AppStarted());
  }
}

class ProductsBloc extends CrudBloc<Product> {
  ProductsBloc(ServiceProvider servicesProvider) : super(servicesProvider);

  factory ProductsBloc.started(ServiceProvider servicesProvider) {
    return ProductsBloc(servicesProvider)..add(AppStarted());
  }
}

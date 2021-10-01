import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart'
    show CrudBloc, AppStarted;
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/data_filter.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

class ProductsBloc extends CrudBloc<Product> {
  ProductsBloc(
    ServiceProvider servicesProvider, [
    DataFilter<Product, String>? initialFilter,
  ]) : super(servicesProvider, initialFilter);

  factory ProductsBloc.started(
    ServiceProvider servicesProvider, [
    DataFilter<Product, String>? initialFilter,
  ]) {
    return ProductsBloc(servicesProvider, initialFilter)..add(AppStarted());
  }
}

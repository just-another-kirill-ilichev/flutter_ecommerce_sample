import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart'
    show CrudBloc, AppStarted;
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

class ProductsBloc extends CrudBloc<Product> {
  ProductsBloc(ServiceProvider servicesProvider) : super(servicesProvider);

  factory ProductsBloc.started(ServiceProvider servicesProvider) {
    return ProductsBloc(servicesProvider)..add(AppStarted());
  }
}

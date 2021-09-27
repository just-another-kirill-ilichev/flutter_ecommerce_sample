import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_event.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_state.dart';
import 'package:flutter_ecommerce_sample/domain/service/database_service.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final DatabaseServiceBase databaseService;
  StreamSubscription? _productsSubscription;

  ProductsBloc(this.databaseService) : super(ProductsInitial()) {
    on<DataProviderInitialized>(_onDataProviderInitialized);
    on<ProductsDataChanged>(_onProductsDataChanged);
  }

  void _onDataProviderInitialized(
    DataProviderInitialized event,
    Emitter<ProductsState> emit,
  ) {
    emit(ProductsLoadInProgress());
    _productsSubscription?.cancel();
    _productsSubscription = databaseService.productRepository
        .getStreamAll()
        .listen((products) => add(ProductsDataChanged(products)))
      ..onError((err) => emit(ProductsLoadError(err.toString())));
  }

  void _onProductsDataChanged(
    ProductsDataChanged event,
    Emitter<ProductsState> emit,
  ) {
    emit(ProductsLoadSuccess(event.products));
  }
}

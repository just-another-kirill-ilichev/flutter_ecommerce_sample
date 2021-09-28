import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ServiceProvider serviceProvider;
  StreamSubscription? _productsSubscription;

  ProductsBloc(this.serviceProvider) : super(ProductsInitial()) {
    on<AppStarted>(_onDataProviderInitialized);
    on<ProductsDataChanged>(_onProductsDataChanged);
  }

  factory ProductsBloc.started(ServiceProvider servicesProvider) {
    return ProductsBloc(servicesProvider)..add(AppStarted());
  }

  Future<void> _onDataProviderInitialized(
    AppStarted event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadInProgress());

    var databaseService = await serviceProvider.databaseService;

    _productsSubscription?.cancel();
    _productsSubscription = databaseService.productRepository
        .getStreamAll()
        .listen((products) => add(ProductsDataChanged(products)))
      ..onError((err) => emit(ProductsLoadError(err.toString()))); // TODO
  }

  void _onProductsDataChanged(
    ProductsDataChanged event,
    Emitter<ProductsState> emit,
  ) {
    emit(ProductsLoadSuccess(event.products));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_event.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_state.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/repository/firebase_repository.dart';
import 'package:flutter_ecommerce_sample/domain/repository/document_serializer.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  late FirebaseRepository<Product> _repository;
  StreamSubscription? _productsSubscription;

  ProductsBloc(ProductsState initialState) : super(initialState) {
    _repository = FirebaseRepository(
      '/products',
      DocumentSerializer((id, data) => Product.fromMap(id, data)),
    );
  }

  factory ProductsBloc.initial() {
    return ProductsBloc(ProductsState(false, []))..add(LoadProductsEvent());
  }

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is LoadProductsEvent) {
      _productsSubscription?.cancel();
      _productsSubscription = _repository
          .getStreamAll()
          .listen((products) => add(UpdateProductsEvent(products)));
    }
    if (event is UpdateProductsEvent) {
      yield ProductsState(true, event.products);
    }
  }
}

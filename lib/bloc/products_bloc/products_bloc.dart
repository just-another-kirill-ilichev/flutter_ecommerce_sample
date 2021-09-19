import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_event.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_state.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(ProductsState initialState) : super(initialState);

  factory ProductsBloc.initial() {
    return ProductsBloc(ProductsState(false, []))..add(LoadProductsEvent());
  }

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is LoadProductsEvent) {
      // TODO Load events form firestore

      await Future.delayed(const Duration(seconds: 2));

      var product = Product(
        title: 'title',
        description: 'description',
        price: Decimal.parse('111.11'),
      );

      var products = List.filled(10, product);

      yield ProductsState(true, products);
    }
  }
}

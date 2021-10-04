import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class CartButtons extends StatelessWidget {
  final Product product;

  const CartButtons({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) {
        var productIndex = state.items.indexWhere(
          (e) => e.product.id == product.id,
        );

        return productIndex == -1 ? 0 : state.items[productIndex].amount;
      },
      builder: (ctx, amount) {
        if (amount == 0) {
          return IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _increment(context),
          );
        }

        return Row(children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => _decrement(context),
          ),
          Text('$amount'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _increment(context),
          ),
        ]);
      },
    );
  }

  void _increment(BuildContext context) =>
      _emit(context, ItemsAdded(product, 1));

  void _decrement(BuildContext context) =>
      _emit(context, ItemsRemoved(product, 1));

  void _emit(BuildContext context, CartEvent event) =>
      BlocProvider.of<CartBloc>(context, listen: false).add(event);
}

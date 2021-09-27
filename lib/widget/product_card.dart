import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_state.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product?.title ?? 'DELETED', style: textTheme.headline6),
            const SizedBox(height: 2),
            Text(
              product?.description ?? '',
              style: textTheme.caption,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product?.price ?? 0} руб ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _CartButtons(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartButtons extends StatelessWidget {
  final Product? product;

  const _CartButtons({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) {
        var productIndex = state.items.indexWhere(
          (e) => e.product.id == product?.id,
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
      _emit(context, ItemsAdded(product!, 1));

  void _decrement(BuildContext context) =>
      _emit(context, ItemsRemoved(product!, 1));

  void _emit(BuildContext context, CartEvent event) =>
      BlocProvider.of<CartBloc>(context, listen: false).add(event);
}

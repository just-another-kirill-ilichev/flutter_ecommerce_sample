import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

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
            Text(product.title, style: textTheme.headline6),
            const SizedBox(height: 2),
            Text(
              product.description,
              style: textTheme.caption,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price} руб ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _onAddPressed(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onAddPressed(BuildContext context) {
    var bloc = BlocProvider.of<CartBloc>(context, listen: false);
    var item = OrderItem(product: product, amount: 1);
    var event = AddItemToCartEvent(item);

    bloc.add(event);
  }
}

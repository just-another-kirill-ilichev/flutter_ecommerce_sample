import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_ecommerce_sample/domain/model/order_item.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Product(
      title: 'title',
      description: 'description',
      price: Decimal.parse('111.11'),
    );

    return ListView.builder(
      itemBuilder: (_, index) => _buildProduct(context, product),
      itemCount: 5,
    );
  }

  Widget _buildProduct(BuildContext context, Product product) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.description),
      trailing: Text('${product.price} руб '),
      leading: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => BlocProvider.of<CartBloc>(context, listen: false)
            .add(AddItemToCartEvent(OrderItem(product: product, amount: 1))),
      ),
    );
  }
}

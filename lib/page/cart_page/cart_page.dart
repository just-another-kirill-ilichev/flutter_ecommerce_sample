import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        return ListView.builder(
          itemBuilder: (_, idx) => ListTile(
            title: Text(state.items[idx].product.title),
            trailing: Text(state.items[idx].amount.toString()),
          ),
          itemCount: state.items.length,
        );
        // return const Center(child: Text('Корзина'));
      },
    );
  }
}

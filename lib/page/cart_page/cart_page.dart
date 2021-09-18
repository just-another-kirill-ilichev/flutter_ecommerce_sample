import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) => CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Корзина', style: TextStyle(color: Colors.black)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, idx) => ListTile(
                title: Text(state.items[idx].product.title),
                trailing: Text(state.items[idx].amount.toString()),
              ),
              childCount: state.items.length,
            ),
          )
        ],
      ),
    );
  }
}

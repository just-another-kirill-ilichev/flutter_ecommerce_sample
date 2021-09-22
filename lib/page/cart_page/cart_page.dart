import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_state.dart';
import 'package:flutter_ecommerce_sample/widget/product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) => CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Корзина', style: TextStyle(color: Colors.black)),
            ),
            actions: [
              IconButton(
                onPressed: () => _onClearPressed(context),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, idx) => ProductCard(product: state.items[idx].product),
              childCount: state.items.length,
            ),
          )
        ],
      ),
    );
  }

  void _onClearPressed(BuildContext context) {
    var bloc = BlocProvider.of<CartBloc>(context, listen: false);
    var event = ClearCartEvent();

    bloc.add(event);
  }
}

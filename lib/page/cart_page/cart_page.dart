import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_state.dart';
import 'package:flutter_ecommerce_sample/domain/model/order.dart';
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
          // TODO: Fix UI and show this button only if:
          // 1) User is authenticated
          // 2) Cart has items
          SliverToBoxAdapter(
            child: ElevatedButton(
              child: Text('Order'),
              onPressed: () => _onOrderPressed(context),
            ),
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

  void _onOrderPressed(BuildContext context) =>
      _emit(context, OrderRequested(DeliveryInfo()));

  void _onClearPressed(BuildContext context) => _emit(context, ItemsCleared());

  void _emit(BuildContext context, CartEvent event) =>
      BlocProvider.of<CartBloc>(context, listen: false).add(event);
}

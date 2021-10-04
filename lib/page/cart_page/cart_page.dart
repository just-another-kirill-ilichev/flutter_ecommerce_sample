import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/widget/cart_buttons.dart';
import 'package:flutter_ecommerce_sample/widget/product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) => CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 16, bottom: 18),
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
              (_, idx) => ProductCard(
                product: state.items[idx].product,
                trailing: CartButtons(product: state.items[idx].product),
              ),
              childCount: state.items.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 128, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _buildButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
      child: const Text('ЗАКАЗАТЬ'),
      onPressed: () => _onOrderPressed(context),
    );
  }

  void _onOrderPressed(BuildContext context) => _emit(
      context,
      OrderRequested(DeliveryInfo(
        // TODO: Add actual data
        address: 'placeholder',
        date: DateTime.now().add(const Duration(days: 1)),
      )));

  void _onClearPressed(BuildContext context) => _emit(context, ItemsCleared());

  void _emit(BuildContext context, CartEvent event) =>
      BlocProvider.of<CartBloc>(context, listen: false).add(event);
}

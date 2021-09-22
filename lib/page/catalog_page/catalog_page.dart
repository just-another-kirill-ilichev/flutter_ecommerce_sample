import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_state.dart';
import 'package:flutter_ecommerce_sample/widget/product_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (_, state) {
        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Каталог', style: TextStyle(color: Colors.black)),
              ),
            ),
            state.isLoaded ? _buildList(state) : _buildLoading(),
          ],
        );
      },
    );
  }

  Widget _buildList(ProductsState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => ProductCard(product: state.products[index]),
        childCount: state.products.length,
      ),
    );
  }

  Widget _buildLoading() {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

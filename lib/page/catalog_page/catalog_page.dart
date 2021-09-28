import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/blocs.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/widget/product_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, CrudState<Product>>(
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
            // TODO: error state
            state is DataLoadSuccess<Product>
                ? _buildList(state)
                : _buildLoading(),
          ],
        );
      },
    );
  }

  Widget _buildList(DataLoadSuccess<Product> state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => ProductCard(product: state.data[index]),
        childCount: state.data.length,
      ),
    );
  }

  Widget _buildLoading() {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

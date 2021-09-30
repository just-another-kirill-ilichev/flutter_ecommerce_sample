import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
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
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 16, bottom: 18),
                title: Text('Каталог', style: TextStyle(color: Colors.black)),
              ),
            ),
            _buildBody(state),
          ],
        );
      },
    );
  }

  Widget _buildBody(CrudState<Product> state) {
    if (state is DataLoadSuccess<Product>) {
      return _buildList(state);
    }
    if (state is DataLoadError<Product>) {
      return _buildError();
    }
    return _buildLoading();
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

  Widget _buildError() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 36,
            ),
            SizedBox(height: 4),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                'Произошла ошибка при загрузке данных',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

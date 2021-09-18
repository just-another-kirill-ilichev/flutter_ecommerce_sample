import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/page/catalog_page/product_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Product(
      title: 'title',
      description: 'description',
      price: Decimal.parse('111.11'),
    );

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text('Каталог', style: TextStyle(color: Colors.black)),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => ProductCard(product: product),
            childCount: 5,
          ),
        )
      ],
    );
  }
}

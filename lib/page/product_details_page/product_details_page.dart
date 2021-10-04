import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/widget/cart_buttons.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: product.photoUrl != null
                  ? Image.network(product.photoUrl!, fit: BoxFit.cover)
                  : const SizedBox(),
              centerTitle: false,
              titlePadding: const EdgeInsets.all(32),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} руб',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CartButtons(product: product),
                    ],
                  ),
                  Text(product.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

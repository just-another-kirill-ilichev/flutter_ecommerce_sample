import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final Widget? trailing;

  const ProductCard({
    Key? key,
    required this.product,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showDetails(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
        child: Row(
          children: [
            Expanded(flex: 2, child: _buildImage()),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product?.title ?? 'DELETED', style: textTheme.headline6),
                  const SizedBox(height: 4),
                  Text(
                    product?.description ?? '',
                    style: textTheme.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          '${product?.price ?? 0} руб ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (trailing != null) trailing!,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
            )
          ],
        ),
        child: product?.photoUrl == null
            ? const Icon(Icons.image_outlined, size: 48, color: Colors.grey)
            : Image.network(product!.photoUrl!, fit: BoxFit.cover),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    if (product == null) {
      return;
    }
    Navigator.pushNamed(context, AppRouter.productDetails, arguments: product);
  }
}

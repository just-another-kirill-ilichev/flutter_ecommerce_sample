import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/page/order_details_page/order_details_page.dart';
import 'package:flutter_ecommerce_sample/page/order_history_page/order_history_page.dart';
import 'package:flutter_ecommerce_sample/page/product_details_page/product_details_page.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

abstract class AppRouter {
  static const catalog = '/catalog';
  static const cart = '/cart';
  static const account = '/account';
  static const orderHistory = '/orderHistory';
  static const orderDetails = '/orderDetails';
  static const productDetails = '/productDetails';

  static Route _materialRoute(Widget page) {
    return MaterialPageRoute(builder: (ctx) => page);
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case catalog:
        return _materialRoute(const NavigationWrapper(index: 0));
      case cart:
        return _materialRoute(const NavigationWrapper(index: 1));
      case account:
        return _materialRoute(const NavigationWrapper(index: 2));
      case orderHistory:
        return _materialRoute(const OrderHistoryPage());
      case orderDetails:
        return _materialRoute(
          OrderDetailsPage(order: settings.arguments as Order),
        );
      case productDetails:
        return _materialRoute(
          // TODO: Create page args class
          ProductDetailsPage(product: settings.arguments as Product),
        );
    }
  }
}

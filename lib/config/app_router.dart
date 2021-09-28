import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

abstract class AppRouter {
  static const catalog = '/catalog';
  static const cart = '/cart';
  static const account = '/account';

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
    }
  }
}

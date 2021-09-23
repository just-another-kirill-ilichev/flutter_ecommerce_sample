import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/main.dart';
import 'package:flutter_ecommerce_sample/page/error_page/error_page.dart';
import 'package:flutter_ecommerce_sample/page/startup_page/startup_page.dart';

abstract class AppRouter {
  static const startup = '/startup';
  static const error = '/error';
  static const home = '/home';

  static Route _materialRoute(Widget page) {
    return MaterialPageRoute(builder: (ctx) => page);
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startup:
        return _materialRoute(const StartupPage());
      case error:
        var errorText = settings.arguments as String;
        return _materialRoute(ErrorPage(errorText: errorText));
      case home:
        return _materialRoute(const AppFlow());
    }
  }
}

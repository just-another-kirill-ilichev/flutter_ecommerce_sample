import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_event.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/config/app_theme.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/domain/repository/document_serializer.dart';
import 'package:flutter_ecommerce_sample/domain/repository/firebase_repository.dart';
import 'package:flutter_ecommerce_sample/domain/service/auth_service.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

import 'domain/model/product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.startup,
    );
  }
}

abstract class AppFlowRouter {
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

class AppFlow extends StatelessWidget {
  const AppFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepository = FirebaseRepository<User>(
      '/users',
      DocumentSerializer((id, data) => User.fromMap(id, data)),
    );

    final productRepository = FirebaseRepository<Product>(
      '/products',
      DocumentSerializer((id, data) => Product.fromMap(id, data)),
    );

    final authService = AuthService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authService, userRepository)
            ..add(AuthServiceInitialized()),
        ),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<ProductsBloc>(
          create: (_) =>
              ProductsBloc(productRepository)..add(DataProviderInitialized()),
        ),
      ],
      child: const Navigator(
        onGenerateRoute: AppFlowRouter.onGenerateRoute,
        initialRoute: AppFlowRouter.catalog,
      ),
    );
  }
}

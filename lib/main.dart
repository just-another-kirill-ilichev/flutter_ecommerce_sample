import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.startup,
    );
  }
}

class AppFlow extends StatelessWidget {
  const AppFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (_) => CartBloc.initial()),
        BlocProvider<ProductsBloc>(create: (_) => ProductsBloc.initial()),
      ],
      // TODO: Add navigation
      child: const NavigationWrapper(index: 0),
    );
  }
}

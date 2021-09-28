import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/config/app_theme.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var serviceProvider = ServiceProvider()..initialize();

  runApp(App(serviceProvider: serviceProvider));
}

class App extends StatelessWidget {
  final ServiceProvider serviceProvider;

  const App({Key? key, required this.serviceProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authBloc = AuthBloc.started(serviceProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc.started(authBloc, serviceProvider),
        ),
        BlocProvider<ProductsBloc>(
          create: (_) => ProductsBloc.started(serviceProvider),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.catalog,
      ),
    );
  }
}

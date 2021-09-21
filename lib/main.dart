import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/page/error_page/error_page.dart';
import 'package:flutter_ecommerce_sample/page/loading_page/loading_page.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initializeFirebase = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _initializeFirebase,
      ]),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: LoadingPage());
        }

        if (snapshot.hasError) {
          return const MaterialApp(
            home: ErrorPage(
              // TODO: Text localization
              errorText: 'Произошла ошибка при инициализации приложения',
            ),
          );
        }

        return _buildApp();
      },
    );
  }

  Widget _buildApp() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (_) => CartBloc.initial()),
        BlocProvider<ProductsBloc>(create: (_) => ProductsBloc.initial()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: ThemeData.light().scaffoldBackgroundColor,
          ),
        ),
        home: const NavigationWrapper(index: 0),
      ),
    );
  }
}

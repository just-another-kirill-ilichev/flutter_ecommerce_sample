import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_sample/widget/navigation_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (_) => CartBloc.initial(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NavigationWrapper(index: 0),
      ),
    );
  }
}

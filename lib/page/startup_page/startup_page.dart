import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final List<Future> startupTasks = [
    Firebase.initializeApp(),
  ];

  @override
  void initState() {
    Future.wait(startupTasks)
        .then((_) => _navigate(AppRouter.home))
        // TODO?: Send logs
        // TODO: Text localization
        .onError((_, __) => _navigate(
              AppRouter.error,
              'Произошла ошибка при инициализации приложения',
            ));

    super.initState();
  }

  void _navigate(String route, [dynamic args]) {
    Navigator.of(context).pushReplacementNamed(route, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // TODO: Return something like app logo instead of progress indicator
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorText;

  const ErrorPage({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.errorColor,
            ),
            const SizedBox(height: 8),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

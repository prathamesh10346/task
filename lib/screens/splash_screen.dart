import 'package:flutter/material.dart';
import 'package:task/utils/routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, authRoute),
    );

    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}

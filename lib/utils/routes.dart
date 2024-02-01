import 'package:flutter/material.dart';
import 'package:task/screens/auth_screen.dart';
import 'package:task/screens/login_view.dart';
import 'package:task/screens/splash_screen.dart';

const String splashRoute = '/splash';
const String authRoute = '/auth';
const String loginRoute = '/login';
const String signupRoute = '/signup';
const String todoRoute = '/todo';

Map<String, WidgetBuilder> getRoutes() {
  return {
    splashRoute: (context) => SplashScreen(),
    authRoute: (context) => AuthScreen(),
    loginRoute: (context) => LoginScreen(),
  };
}

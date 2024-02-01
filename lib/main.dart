import 'package:flutter/material.dart';
import 'package:task/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      initialRoute: splashRoute,
      routes: getRoutes(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trading/login_regis/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

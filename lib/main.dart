// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trading/login_regis/login_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized;
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        theme: ThemeData(
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        // Define the default font family.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
       darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
        ),
      ),
            themeMode: ThemeMode.system,  // Use system theme setting

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

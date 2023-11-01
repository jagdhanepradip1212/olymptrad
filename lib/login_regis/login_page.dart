import 'package:flutter/material.dart';
import 'package:trading/graph_page.dart';
// import 'package:trading/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // TODO: Add your login logic here
    // For now, we will just navigate to the main page

    final username = _usernameController.text;
    final password = _passwordController.text;

    // Placeholder for actual authentication logic
    // if (username == 'admin' && password == 'password') {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TradingPage()));
    // }
    //  else {
    //   // Show error message
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Invalid username or password')),
    //   );
    // }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TradingPage()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

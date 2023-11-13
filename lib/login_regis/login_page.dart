import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trading/graph_page.dart';
import 'package:trading/login_regis/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;

    @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

    void _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      _navigateToTradingPage();
    }
  }

    void _navigateToTradingPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) =>  TradingPage()),
    );
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }


  
  void _navigateToRegister() {
    // This will push the RegisterPage onto the navigation stack,
    // allowing the user to return to the AuthScreen by popping the RegisterPage.
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      final response = await http.post(
        Uri.parse('https://olyimtrade.wilatonprojects.com/login'),
        headers: {'Content-Type': 'application/json',
        "Access-Control-Allow-Origin":
              "*", 
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
         final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
                _navigateToTradingPage();

        print('Login successful');
        // Navigate to another page if needed
      } else {
        print('Login failed');
                final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);
      }
    } catch (error) {
      print('An error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _isLogin = true),
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: _isLogin ? Colors.deepPurple : Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
            onPressed: _navigateToRegister,
            child: Text('Switch to Register'),
            style: ElevatedButton.styleFrom(
              primary: !_isLogin ? Colors.deepPurple : Colors.grey,
            ),
          ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                      ElevatedButton(
            onPressed: () {
              if (_isLogin) {
                _login();
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  TradingPage()));

              } else {
                // The navigation logic has been moved to _navigateToRegister function
                _navigateToRegister();
              }
            },
            child: Text(_isLogin ? 'Login' : 'Go to Register'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
            ),
          ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

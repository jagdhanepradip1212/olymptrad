import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonalSettingPage extends StatefulWidget {
  @override
  _PersonalSettingPageState createState() => _PersonalSettingPageState();
}

class _PersonalSettingPageState extends State<PersonalSettingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the state object is removed.
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstNameController.text = prefs.getString('name') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _phoneController.text = prefs.getString('phone_no') ?? '';
  }

  // This function is used to save data to SharedPreferences
  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _firstNameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone_no', _phoneController.text);
  }

  @override
  void initState() {
    super.initState();
    loadUserData(); // Load user data when the widget is initialized
  }

  Future<void> updateUser(String id) async {
    final url =
        Uri.parse('https://olyimtrade.wilatonprojects.com/personalsettings');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': _firstNameController.text,
          'email': _emailController.text,
          'phone_no': _phoneController.text,
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        await saveUserData();
        print('User updated: ${response.body}');
        print('Status Code: ${response.statusCode}');
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to update user.');
      }
    } catch (e) {
      // This captures any other kind of exception that could occur
      print('Error occurred while trying to send data: $e');
      throw Exception('Error occurred while trying to send data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 231, 231),
      appBar: AppBar(
        title: const Text('Personal Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Personal",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your first name',
                  fillColor: const Color.fromARGB(255, 115, 113, 113),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              const SizedBox(height: 8),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your email',
                  fillColor: const Color.fromARGB(255, 115, 113, 113),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              const Text(
                "Phone",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your phone',
                  fillColor: const Color.fromARGB(255, 115, 113, 113),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String userId = "29"; // Replace with actual user ID
                      updateUser(userId).then((_) {
                        print('User data saved successfully');
                      }).catchError((error) {
                        // Handle the error in your UI
                        print('Failed to save user data: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to update user.'),
                          ),
                        );
                      });
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _betAmountController = TextEditingController();
  final TextEditingController _upiNoController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, display a loading indicator and make the API call
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await http.post(
          Uri.parse('https://olyimtrade.wilatonprojects.com/add-user'),
          headers: {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: json.encode({
            'username': _usernameController.text,
            'balance': _betAmountController.text,
            'upi_no': _upiNoController.text,
          }),
        );
        print(response.body);
        print('Status code: ${response.statusCode}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // If server returns an OK response, parse the JSON
          print('User added successfully! $data');
        } else {
          // If server returns a failed response, throw an exception.
          print('Failed to add user.');
        }
      } catch (error) {
        print('Error: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _usernameController.dispose();
    _betAmountController.dispose();
    _upiNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username',
                  fillColor: Color.fromARGB(255, 115, 113, 113),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },

                // onChanged: (value) {
                //   _username = value;
                // },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _betAmountController,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter amount',
                  fillColor: Color.fromARGB(255, 123, 120, 120),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bet amount';
                  }
                  return null;
                },

                //  onChanged: (value) {
                //   _betAmount = value;
                // },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _upiNoController,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter upi amount',
                  fillColor: Color.fromARGB(255, 131, 129, 129),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Upi num.';
                  }
                  return null;
                },

                //  onChanged: (value) {
                //   _upiNo = value;
                // },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 160, 107, 207), // Button color
                  onPrimary: Colors.white, // Text color
                ),
                // onPressed: _isLoading ? null : _submitForm,
                onPressed: () {
                  _submitForm();
                  print(_usernameController);
                  print(_betAmountController);
                  print(_betAmountController);
                },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

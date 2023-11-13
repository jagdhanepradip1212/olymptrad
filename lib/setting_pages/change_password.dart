import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String passwordStrengthText = "";
  double passwordStrength = 0.0;
  bool isPasswordCompliant = false;

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_checkPasswordStrength);
    _loadCurrentPassword();
  }

  _loadCurrentPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Assuming your current password key is 'currentPassword'
      currentPasswordController.text = prefs.getString('currentPassword') ?? '';
    });
  }

  _checkPasswordStrength() {
    String password = newPasswordController.text;
    double strength = estimatePasswordStrength(password);

    setState(() {
      passwordStrength = strength;
      if (strength < 0.3) {
        passwordStrengthText = "Weak";
      } else if (strength < 0.7) {
        passwordStrengthText = "Medium";
      } else {
        passwordStrengthText = "Strong";
      }

      isPasswordCompliant = strength > 0.7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
            SizedBox(height: 20),
            Text(
              'Password Strength: $passwordStrengthText',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: passwordStrength,
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isPasswordCompliant &&
                      newPasswordController.text ==
                          confirmPasswordController.text
                  ? _changePassword
                  : null,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    // Add your API URL here
    var url = Uri.parse(
        'https://olyimtrade.wilatonprojects.com/updatepassword/{id}');

    try {
      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'currentPassword': currentPasswordController.text,
          'newPassword': newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully.');
        // You can also update the saved password in SharedPreferences here if needed
      } else {
        print('Failed to change password. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error changing password: $e');
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(home: ChangePasswordPage()));
}

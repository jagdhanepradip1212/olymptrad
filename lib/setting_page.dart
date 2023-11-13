import 'package:flutter/material.dart';
import 'package:trading/login_regis/login_page.dart';
import 'package:trading/setting_pages/change_password.dart';
import 'package:trading/setting_pages/personal_setting.dart';
import 'package:trading/setting_pages/two_factor_auth.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
                  backgroundColor: Color.fromARGB(255, 24, 24, 24), // AppBar with black background

        ),
              backgroundColor: Color.fromARGB(255, 34, 32, 32), // Scaffold background color

        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.white), // Icon color for contrast

                  title: Text('Personal Setting', style: TextStyle(color: Colors.white)), // Text color for contrast
                    onTap: () {
                      // Add your logic to navigate to the Personal Setting page
       Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>  PersonalSettingPage()));

                    },
                  ),
                  ListTile(
                  leading: const Icon(Icons.security, color: Colors.white), // Icon color for contrast
                  title: Text('Two-Factor Authentication', style: TextStyle(color: Colors.white)), // Text color for contrast
                    onTap: () {
                      // Add your logic to navigate to the Two-Factor Authentication page
                      // For example, Navigator.push(...);
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TwoFacAuthPage()),
  );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                        Icons.password_outlined), // Add the icon here

                  title: Text('Password', style: TextStyle(color: Colors.white)), // Text color for contrast
                    onTap: () {
                      // Add your logic to navigate to the Password page
                      // For example, Navigator.push(...);
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChangePasswordPage()),
  );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                  primary: Colors.grey[850], // Darker grey color for the button
                  onPrimary: Colors.white, // Text color for the button
                ),
                  onPressed: () {
                    // Add your logout logic here
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AuthScreen()),
  );
                  },
                icon: const Icon(Icons.logout, color: Colors.white), // Icon color for contrast
                  label: Text('Logout'),
                ),
              ),
            ),
          ],
        ));
  }
}

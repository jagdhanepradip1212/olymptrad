import 'package:flutter/material.dart';
import 'package:trading/setting_pages/personal_setting.dart';
import 'package:trading/setting_pages/two_factor_auth.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                        Icons.person_2_outlined), // Add the icon here

                    title: Text('Personal Setting'),
                    onTap: () {
                      // Add your logic to navigate to the Personal Setting page
       Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>  PersonalSettingPage()));

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.security), // Add the icon here
                    title: Text('Two-Factor Authentication'),
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

                    title: Text('Password'),
                    onTap: () {
                      // Add your logic to navigate to the Password page
                      // For example, Navigator.push(...);
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
                  onPressed: () {
                    // Add your logout logic here
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                ),
              ),
            ),
          ],
        ));
  }
}

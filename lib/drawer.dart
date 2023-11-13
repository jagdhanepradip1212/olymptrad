import 'package:flutter/material.dart';
import 'package:trading/show_users.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Your Name"),
            accountEmail: Text("your_email@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "Y",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text('All Users'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Add navigation logic here
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  UserTable()),
  );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Add navigation logic here
            },
          ),
          // Add more ListTiles here
        ],
      ),
    );
  }
}

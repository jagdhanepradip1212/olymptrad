import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/setting_page.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  Future<String> _getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ??
        'User'; // Use your stored username key
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 4,
      ),
            body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text(
          //     'Profile',
          //     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 246, 246, 247)),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.deepPurple.shade50,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: _getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error: Could not load user name');
                        } else {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                          );
                        }
                      },
                    ),
                    const Text(
                      'User ID: 12345',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ... other widgets ...
           Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 120, 119, 119), // Set Card background to black
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade200,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Started',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '29 days',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level 1',
                    style: TextStyle(
                      color: Colors.deepPurple[300],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '0/50 XP',
                    style: TextStyle(
                      color: Colors.deepPurple[300],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                value: 10, // This should be the current value of your slider
                min: 0, // This should be the minimum value of your slider
                max: 50, // This should be the maximum value of your slider
                onChanged: (value) {
                  // Handle slider value change
                },
                activeColor: Colors.deepPurple,
                inactiveColor: const Color.fromARGB(255, 107, 97, 126),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCardWidget(Icons.account_balance_wallet, "Wallet"),
            _buildCardWidget(Icons.history, "History"),
          ],
        ),
          const SizedBox(height: 26),
        ElevatedButton(
          onPressed: () {
            // Navigate to the setting page here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            primary: const Color.fromARGB(255, 120, 119, 119),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            shadowColor: Colors.deepPurple.shade300,
            elevation: 10,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize
                .min, // To prevent the button from stretching to the full width
            children: [
              Icon(Icons.settings, size: 32, color: Colors.white),
              SizedBox(width: 24),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );

  }

  Widget _buildCardWidget(IconData icon, String text) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 120, 119, 119),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Icon(icon, size: 30, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text(
              text,
              style: TextStyle(fontSize: 18.0, color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}

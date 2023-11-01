import 'package:flutter/material.dart';
import 'package:trading/setting_page.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Replace with your image URL
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('User ID: 12345'), // Replace with the actual user ID
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Level 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '29 days',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '0/50 XP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Slider(
                  value: 10, // This should be the current value of your slider
                  min: 0, // This should be the minimum value of your slider
                  max: 50, // This should be the maximum value of your slider
                  onChanged: (value) {
                    // Handle slider value change
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Stack(
        children: [
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Icon(Icons.add_alert_rounded),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text("ddd", style: TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
        ),

      //   Container(
      //     width: 200,
      //     height: 200,
      //     decoration: BoxDecoration(
      //   color: Colors.grey[300],
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      // child: const Stack(
      //   children: [
      //     Positioned(
      //       top: 16.0,
      //       left: 16.0,
      //       child: Icon(Icons.access_alarm_outlined),
      //     ),
      //     Positioned(
      //       bottom: 16.0,
      //       left: 16.0,
      //       child: Text("aaa", style: TextStyle(fontSize: 18.0)),
      //     ),
      //   ],
      // ),
      //   )
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
        padding: const EdgeInsets.all(10.0),
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
       child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            SizedBox(width: 16),
            Text(
              'Setting',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
),

      // SizedBox(height: 8),
      // Container(
      //             padding: const EdgeInsets.all(10.0),

      //   decoration: BoxDecoration(
      //       color: Colors.blue,
      //       borderRadius: BorderRadius.circular(10.0),
      //     ),
      //       child: const Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.settings,
      //               size: 32,
      //               color: Colors.white,
      //             ),
      //             SizedBox(width: 16),
      //             Text(
      //               'Setting',
      //               style: TextStyle(
      //                 fontSize: 24,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
       
      ],
    );
  }
}

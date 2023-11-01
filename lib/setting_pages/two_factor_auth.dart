import 'package:flutter/material.dart';

class TwoFacAuthPage extends StatefulWidget {
  const TwoFacAuthPage({super.key});

  @override
  _TwoFacAuthPageState createState() => _TwoFacAuthPageState();
}

class _TwoFacAuthPageState extends State<TwoFacAuthPage> {
  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the container width based on the screen width
    double containerWidth = screenWidth > 600 ? 200 : screenWidth * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Two Factor Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To enable two-factor authentication, scan the QR code with one of the following apps:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: containerWidth,
                        height: 200,
                        color: Color.fromARGB(255, 112, 112, 112),
                        child: const Center(
                          child: Text('Facebook Messenger'),
                        ),
                      ),
                      const Positioned(
                        top: 8,
                        left: 8,
                        child: Icon(Icons.facebook, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Stack(
                    children: [
                      Container(
                        width: containerWidth,
                        height: 200,
                        color: Color.fromARGB(255, 137, 137, 137),
                        child: const Center(
                          child: Text('Google Authenticator'),
                        ),
                      ),
                      const Positioned(
                        top: 8,
                        left: 8,
                        child: Icon(Icons.security, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

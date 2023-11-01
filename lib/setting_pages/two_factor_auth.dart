import 'package:flutter/material.dart';

class TwoFacAuthPage extends StatefulWidget {
  @override
  _TwoFacAuthPageState createState() => _TwoFacAuthPageState();
}

class _TwoFacAuthPageState extends State<TwoFacAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Factor Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
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
                  Container(
                    width: 200,
                    height: 200,
                    color: Color.fromARGB(255, 207, 157, 153),
                    child: Center(
                      child: Text('Facebook Messenger'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 200,
                    height: 200,
                    color: Color.fromARGB(255, 90, 121, 146),
                    child: Center(
                      child: Text('Google Authenticator'),
                    ),
                  ),
                ],
              ),
            ),
      ],
        ),
        )
      
      
      
      
      
      //  Center(

        
      //   child: Row(
      //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         width: 200,
      //         height: 200,
      //         color: const Color.fromARGB(255, 207, 157, 153), // Color is optional, just for demonstration
      //         child: Center(
      //           child: Text('Facebook Messanger'),
      //         ),
      //       ),
      //       SizedBox(
      //           width:
      //               16), // Optional: To give some space between the containers
      //       Container(
      //         width: 200,
      //         height: 200,
      //         color: Color.fromARGB(255, 90, 121, 146), // Color is optional, just for demonstration
      //         child: Center(
      //           child: Text('Google Authenticator'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

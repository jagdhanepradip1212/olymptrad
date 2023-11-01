import 'package:flutter/material.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Market Tab'),
          const SizedBox(height: 20), // Adds space between text and buttons
          ElevatedButton(
            onPressed: () {
              // Add your logic for the first button here
              print('Button 1 Pressed');
            },
            child: const Text('Button 1'),
          ),
          const SizedBox(height: 10), // Adds space between the two buttons
          ElevatedButton(
            onPressed: () {
              // Add your logic for the second button here
              print('Button 2 Pressed');
            },
            child: const Text('Button 2'),
          ),
        ],
      ),
    );
  }
}

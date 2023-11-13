import 'package:flutter/material.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the Scaffold to black
      appBar: AppBar(
                automaticallyImplyLeading: false, // Prevents the AppBar from showing a back button

        title: const Text(
          'Market',
          style: TextStyle(color: Colors.white), // Title color is already white
        ),
        backgroundColor: Colors.black, // Set the AppBar background to black
        elevation: 4, // Retain the elevation for a subtle shadow
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Card(
            color: const Color.fromARGB(255, 120, 119, 119), // Set Card background to black
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.white), // Set icon color to white
              title: const Text(
                'My Purchases & Rewards',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              onTap: () {
                // Handle the tap action for My Purchases
                print('My Purchases & Rewards Tapped');
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: const Color.fromARGB(255, 120, 119, 119), // Set Card background to black
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.straighten, color: Colors.white), // Set icon color to white
              title: const Text(
                'My Published Strategies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              onTap: () {
                // Handle the tap action for My Published Strategies
                print('My Published Strategies Tapped');
              },
            ),
          ),
          // Continue adding more ListTiles with the same pattern
        ],
      ),
    );
  }
}

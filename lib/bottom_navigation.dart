import 'package:flutter/material.dart';

class TabBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TabBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Trading',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Trades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.markunread_outlined),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color.fromARGB(255, 20, 20, 20),
      unselectedItemColor: const Color.fromARGB(255, 24, 2, 2)
          .withOpacity(0.6), // Set unselected item color to a less opaque white
      onTap: onTap,
    );
  }
}

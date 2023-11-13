class TradingPage extends StatefulWidget {
  @override
  _TradingPageState createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  int timeInMinutes = 1; // Initial time
  int money = 10; // Initial money value
  int _currentIndex = 0; // Current index for bottom navigation

  final List<Widget> _pages = [
    HomeTab(), // Replace with your actual home page widget
    TradesTab(),
    MarketTab(),
    ProfileTab(),
  ];

  // ... your increment and decrement methods ...

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // ... other items ...
        ],
      ),
    );
  }
}

// Define your HomeTab, TradesTab, MarketTab, and ProfileTab widgets

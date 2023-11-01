import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading/drawer.dart';
import 'package:trading/tabs/market_page.dart';
import 'package:trading/tabs/profile_page.dart';
import 'package:trading/tabs/trades_page.dart';
import 'dart:async';

class TradingPage extends StatefulWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TradingTab(),
    const TradesTab(), // Trading tab
    const MarketTab(), // Market tab
    const ProfileTab(), // Profile tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 3, 6, 114),
        unselectedItemColor: Color.fromARGB(233, 89, 100, 86),
        onTap: _onItemTapped,
      ),
    );
  }
}

class TradingTab extends StatefulWidget {
  const TradingTab({Key? key}) : super(key: key);

  @override
  State<TradingTab> createState() => _TradingTabState();
}

class _TradingTabState extends State<TradingTab> {
  int time = 1; // Initial time in minutes
  int money = 10; // Initial money value

  Timer? _timer;
  int _start = 0;

  void _increaseTime() {
    setState(() {
      time++;
    });
  }

  void _decreaseTime() {
    setState(() {
      time = time > 1 ? time - 1 : 1; // Ensure time does not go below 1
    });
  }

  void _increaseMoney() {
    setState(() {
      money += 10;
    });
  }

  void _decreaseMoney() {
    setState(() {
      money = money > 10 ? money - 0 : 0; // Ensure money does not go below 0
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
           child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_timer != null && _timer!.isActive)
              Text("Time Left: $_start"),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Demo Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        ),
       
        Expanded(
          flex: 3,
          child: SfCartesianChart(
            // Initialize the chart data
            series: <ChartSeries>[
              LineSeries<ChartData, double>(
                dataSource: getChartData(),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
            ],
            // Define X and Y axis
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildControlRow(
                      'Time', '${time}min', _increaseTime, _decreaseTime),
                  const SizedBox(width: 4),
                  _buildControlRow(
                      'Money', '\$$money', _increaseMoney, _decreaseMoney),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add your Call button logic here
                      setState(() {
                        _start = time *
                            60; // Assuming 'time' is in minutes, convert to seconds
                      });
                      startTimer();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: ' Call',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.arrow_upward,
                                size: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add your Call button logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(
                          255, 252, 3, 3), // Background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: ' Put',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.arrow_downward,
                                size: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlRow(String label, String value, VoidCallback onIncrease,
      VoidCallback onDecrease) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: const Icon(Icons.remove, color: Colors.blue),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          IconButton(
            onPressed: onIncrease,
            icon: const Icon(Icons.add, color: Colors.blue),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  List<ChartData> getChartData() {
    return [
      ChartData(1, 35),
      ChartData(1.2, 5),
      ChartData(1.6, 30),
      ChartData(1.8, 10),
      ChartData(4, 32),
      ChartData(5, 40)
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading/add_users.dart';
import 'package:trading/drawer.dart';
import 'package:trading/tabs/market_page.dart';
import 'package:trading/tabs/profile_page.dart';
import 'package:trading/tabs/trades_page.dart';
import 'dart:async';
import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:trading/bottom_navigation.dart';
import 'package:rive/rive.dart';

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
      backgroundColor: Colors.black,
          appBar: _selectedIndex != 1 && _selectedIndex != 2 && _selectedIndex != 3 ? _buildAppBar() : null, // Conditionally render AppBar
    drawer: _selectedIndex == 0 ? const CustomDrawer() : null,
body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
     bottomNavigationBar: TabBottomNavigationBar(
          currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    ),
     
    );
  }
AppBar _buildAppBar() {
  return AppBar(
    title: _selectedIndex == 0
        ? const Text("Demo account", style: TextStyle(color: Colors.white))
        : null,
    backgroundColor: Colors.black,
    actions: <Widget>[
      if (_selectedIndex == 0)
        IconButton(
          icon: const Icon(Icons.folder_open),
          onPressed: () {
            _showAddUserBottomSheet(context);
          },
        ),
    ],
  );
}
  
}



void _showAddUserBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Add User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUserPage()));
              },
              child: Text('Go to Add User Page'),
            ),
          ],
        ),
      );
    },
  );
}

GlobalKey<_TradingTabState> pageKey = GlobalKey<_TradingTabState>();

class TradingTab extends StatefulWidget {
  const TradingTab({Key? key}) : super(key: key);

  @override
  State<TradingTab> createState() => _TradingTabState();
}

class _TradingTabState extends State<TradingTab> {
  final String riveTwoMinUpName = 'assets/candle_chart_2min_up.riv';
  final String riveTwoMinDownName = 'assets/candle_chart_2min_down.riv';

  final String riveFileDName =
      'assets/candle_chart_Down_chart_1_min_20_sec.riv';
  final String riveFileUName = 'assets/candle_chart_1_min_up.riv';

  final String riveFiveMinUFile = 'assets/candle_chart_5_min_up.riv';
  final String riveFiveMinDFile = 'assets/candle_chart_5_min_down.riv';

  final String riveTenMinUFile = 'assets/candle_chart_10min_up.riv';
  final String riveTenMinFile = 'assets/candle_chart_10min_down.riv';

  bool playTwoMinUpRive = false;
  bool playTwoMinDownRive = false;

  bool playRiveAnimation = false;
  bool playRive1MinUpAnima = false;

  bool playFiveMinUpRive = false;
  bool playFiveMinDownRive = false;

  bool playTenMinRive = false;
  bool playTenMinUpRive = false;
  String betType = "";

  int time = 1;
  int money = 10;

  Timer? _timer;
  int _start = 0;

  void refreshPage() {
    setState(() {
      // This will create a new key and cause the whole page to be rebuilt from scratch.
      pageKey = GlobalKey<_TradingTabState>();
    });
  }

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
      money = money > 10 ? money - 10 : 10; // Ensure money does not go below 0
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

          // When _start is equal to 1, we want to trigger the Rive animation
          if (time == 1) {
            // Trigger your Rive animation here
            // You will likely need to use a state variable to show/hide the Rive animation
            // For example, you could have a boolean that you set to true to indicate the animation should play
            // playRiveAnimation = true;
            setState(() {
              playRiveAnimation = true;
            });
          }
          // else if (time == 10) {
          //   setState(() {
          //     playTenMinRive = true;
          //   });
          // }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> placeOneBets(String betType) async {
    final url = Uri.parse(
        'https://olyimtrade.wilatonprojects.com/place-bets-and-decide-winner');

    List<Map<String, dynamic>> bets = [
      {
        'userId': 'Shimple',
        'betAmount': money,
        'betType': betType,
      },
      // Add more bets if needed
    ];
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'bets': bets});

    print(money);
    print(betType);
    print(body);
    print(headers);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Bets placed successfully');
        // Handle success response
      } else {
        print('Failed to place bets');
        // Handle error response
      }
    } catch (error) {
      print('Error placing bets: $error');
      // Handle network error
    }
  }

  Future<void> placeBets(String betType) async {
    final url = Uri.parse('https://olyimtrade.wilatonprojects.com/place');

    List<Map<String, dynamic>> bets = [
      {
        'userId': 'Pradip',
        'betAmount': money,
        'betType': betType,
      },
      // Add more bets if needed
    ];
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'bets': bets});

    print(money);
    print(betType);
    print(body);
    print(headers);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Bets placed successfully');
        // Handle success response
      } else {
        print('Failed to place bets');
        // Handle error response
      }
    } catch (error) {
      print('Error placing bets: $error');
      // Handle network error
    }
  }

  Future<void> placeFiveBets(String betType) async {
    final url = Uri.parse('https://olyimtrade.wilatonprojects.com/place-bets');

    List<Map<String, dynamic>> bets = [
      {
        'userId': 'Shimple',
        'betAmount': money,
        'betType': betType,
      },
      // Add more bets if needed
    ];
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'bets': bets});

    print(money);
    print(betType);
    print(body);
    print(headers);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Bets placed successfully');
        // Handle success response
      } else {
        print('Failed to place bets');
        // Handle error response
      }
    } catch (error) {
      print('Error placing bets: $error');
      // Handle network error
    }
  }

  Future<void> placeTenBets(String betType) async {
    final url = Uri.parse(
        'https://olyimtrade.wilatonprojects.com/place-bets-and-decide');

    List<Map<String, dynamic>> bets = [
      {
        'userId': 'Samir',
        'betAmount': money,
        'betType': betType,
      },
      // Add more bets if needed
    ];
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'bets': bets});

    print(money);
    print(betType);
    print(body);
    print(headers);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Bets placed successfully');
        // Handle success response
      } else {
        print('Failed to place bets');
        // Handle error response
      }
    } catch (error) {
      print('Error placing bets: $error');
      // Handle network error
    }
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
                Text(
                  "Time Left: $_start",
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
        Expanded(
            flex: 3,
            child: Stack(
              children: <Widget>[
                SfCartesianChart(
                  series: const <ChartSeries>[],
                ),
                if (playRiveAnimation)
                  Positioned(child: RiveAnimation.asset(riveFileDName))
                else if (playRive1MinUpAnima)
                  Positioned(child: RiveAnimation.asset(riveFileUName))
                else if (playTenMinRive)
                  Positioned(child: RiveAnimation.asset(riveTenMinFile))
                else if (playTenMinUpRive)
                  Positioned(child: RiveAnimation.asset(riveTenMinUFile))
                else if (playTwoMinUpRive)
                  Positioned(child: RiveAnimation.asset(riveTwoMinUpName))
                else if (playTwoMinDownRive)
                  Positioned(child: RiveAnimation.asset(riveTwoMinDownName))
                else if (playFiveMinUpRive)
                  Positioned(child: RiveAnimation.asset(riveFiveMinUFile))
              ],
            )),
        const SizedBox(height: 12),
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
                      'Money', '\$${money}', _increaseMoney, _decreaseMoney),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top:
                            12.0), // Adjust the value as needed for the top margin
                    child: ElevatedButton(
                      onPressed: () {
                        pageKey.currentState?.refreshPage();
                        playRiveAnimation = false;
                        playRive1MinUpAnima = false;
                        playTenMinRive = false;
                        playTenMinUpRive = false;
                        playTwoMinUpRive = false;
                        playTwoMinDownRive = false;
                        // Add your Call button logic here
                        setState(() {
                          _start = time * 60;
                          betType = "";
                          // Assuming 'time' is in minutes, convert to seconds
                        });
                        startTimer();
                        if (time == 2) {
                          placeBets('up');
                          playTwoMinDownRive = true;
                        } else if (time == 1) {
                          placeOneBets("up");
                        } else if (time == 5) {
                          placeFiveBets("up");
                        } else if (time == 10) {
                          placeTenBets("up");
                          playTenMinRive = true;
                        }
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.arrow_upward,
                                  size: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top:
                            12.0), // Adjust the value as needed for the top margin
                    child: ElevatedButton(
                      onPressed: () {
                        pageKey.currentState?.refreshPage();
                        playRiveAnimation = false;
                        playRive1MinUpAnima = false;
                        playTenMinRive = false;
                        playTwoMinUpRive = false;
                        playTwoMinDownRive = false;
                        playFiveMinUpRive = false;
                        setState(() {
                          _start = time * 60;
                          betType = "";
                          // Assuming 'time' is in minutes, convert to seconds
                        });
                        startTimer();
                        if (time == 2) {
                          placeBets('down');
                          playTwoMinUpRive = true;
                        } else if (time == 1) {
                          placeOneBets("down");
                          playRive1MinUpAnima = true;
                        } else if (time == 5) {
                          placeFiveBets("down");
                          playFiveMinUpRive = true;
                        } else if (time == 10) {
                          placeTenBets("down");
                          playTenMinUpRive = true;
                        }
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.arrow_downward,
                                  size: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
}

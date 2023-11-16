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
      appBar: _selectedIndex != 1 && _selectedIndex != 2 && _selectedIndex != 3
          ? _buildAppBar()
          : null, // Conditionally render AppBar
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

  List<TimerInfo> _timers = [];
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

  void _startTimer(int minutes) {
    int initialSeconds = minutes * 60;
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Find the TimerInfo instance for this timer and update its remaining seconds
        var timerInfo = _timers.firstWhere((t) => t.timer == timer);
        if (timerInfo.remainingSeconds > 0) {
          timerInfo.remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });

    _timers.add(TimerInfo(timer, initialSeconds, minutes));
  }

  void _showTimersBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<TimerInfo>>(
          stream: _timersStream(), // Create a stream for active timers
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var timerInfo = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Time Remaining for ${timerInfo.minutes} min: ${timerInfo.remainingSeconds} seconds',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 16, 15, 15),
                          fontSize: 16),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No active timers'),
              );
            }
          },
        );
      },
    );
  }

  Stream<List<TimerInfo>> _timersStream() async* {
    while (_timers.isNotEmpty) {
      yield _timers.where((timerInfo) => timerInfo.timer.isActive).toList();
      await Future.delayed(Duration(seconds: 1)); // Update every second
    }
  }

  @override
  void dispose() {
    for (var timerInfo in _timers) {
      timerInfo.timer.cancel();
    }
    super.dispose();
  }

  Future<void> placeOneBets(String betType) async {
    final url = Uri.parse(
        'https://olyimtrade.wilatonprojects.com/place-bets-and-decide-winner');

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

  Future<void> placeBets(String betType) async {
    final url = Uri.parse('https://olyimtrade.wilatonprojects.com/place');

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
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
// Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     // children: [
                //     //   if (_timer != null && _timer!.isActive)
                //     //     Text(
                //     //       "Time Left: $_start",
                //     //       style: TextStyle(color: Colors.white),
                //     //     ),
                //     // ],
                //   ),
                // ),
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
                          Positioned(
                              child: RiveAnimation.asset(riveTenMinUFile))
                        else if (playTwoMinUpRive)
                          Positioned(
                              child: RiveAnimation.asset(riveTwoMinUpName))
                        else if (playTwoMinDownRive)
                          Positioned(
                              child: RiveAnimation.asset(riveTwoMinDownName))
                        else if (playFiveMinUpRive)
                          Positioned(

                              child: RiveAnimation.asset(riveFiveMinUFile))
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
                          _buildControlRow('Time', '${time}min', _increaseTime,
                              _decreaseTime),
                          const SizedBox(width: 4),
                          _buildControlRow('Money', '\$${money}',
                              _increaseMoney, _decreaseMoney),
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
                                _startTimer(time);
                                if (time == 2) {
                                  placeBets('up');
                                  playTwoMinDownRive = true;
                                } else if (time == 1) {
                                  placeOneBets("up");
                                  playRiveAnimation = true;
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
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
                                _startTimer(time);
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
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
            ),
            Positioned(
               top: 10, // Adjust the top position as needed
          right: 10,
              child: FloatingActionButton(
                onPressed: _showTimersBottomSheet,
            child: const Icon(Icons.timer,
            color: Colors.black,
            size: 15),
            ))

          ],
        ));
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

class TimerInfo {
  Timer timer;
  int remainingSeconds;
  int minutes;

  TimerInfo(this.timer, this.remainingSeconds, this.minutes);
}

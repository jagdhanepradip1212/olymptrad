import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class TradesTab extends StatefulWidget {
  const TradesTab({Key? key}) : super(key: key);

  @override
  _TradesTabState createState() => _TradesTabState();
}

class _TradesTabState extends State<TradesTab> {
  int _selectedIndex = 0;
  late Future<List<TradeData>> tradeDataFuture;
  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    tradeDataFuture =
        fetchTradeData(); // Fetch data when the state is initialized.
    _tabs = [
      FutureBuilder<List<TradeData>>(
        future: tradeDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TradeData data = snapshot.data![index];
                return Card(
                  // Wrapping in a Card for better UI
                  child: ListTile(
                    title: Text('Winning Side: ${data.winningSide}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Up Amount: ${data.totalUpAmount}'),
                        Text('Total Down Amount: ${data.totalDownAmount}'),
                        Text(
                            'Amount Taken By Admin: ${data.amountTakenByAdmin}'),
                        Text('Created At: ${data.createdAt}'),
                        // If earnings is a list of objects, you may want to implement a method to render it suitably
                        // For example, if earnings is a list of strings:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.earnings
                              .map((earning) => Text('Earning: $earning'))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
      Center(child: Text('Forex')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // This removes the back button
          backgroundColor: Colors.black,

          title: const Text('Trades'),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              Tab(text: 'Open Trade'),
              Tab(text: 'Forex'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}

Future<List<TradeData>> fetchTradeData() async {
  final response = await http.get(
    Uri.parse('https://olyimtrade.wilatonprojects.com/totalresults'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = json.decode(response.body);
    // Since your API returns a single object, we create a User from the root object.
    TradeData user = TradeData.fromJson(jsonMap);
    // Return a list containing just our single user.
    return [user];
  } else {
    throw Exception('Failed to load user data');
  }
}

class TradeData {
  final bool success;
  final int id;
  final String winningSide;
  final String totalUpAmount;
  final String totalDownAmount;
  final String amountDistributedToWinners;
  final String amountTakenByAdmin;
  final String createdAt;
  final List<dynamic> earnings;

  TradeData({
    required this.success,
    required this.id,
    required this.winningSide,
    required this.totalUpAmount,
    required this.totalDownAmount,
    required this.amountDistributedToWinners,
    required this.amountTakenByAdmin,
    required this.createdAt,
    required this.earnings,
  });

  factory TradeData.fromJson(Map<String, dynamic> json) {
    return TradeData(
      success: json['success'],
      id: json['id'],
      winningSide: json['winningSide'],
      totalUpAmount: json['totalUpAmount'],
      totalDownAmount: json['totalDownAmount'],
      amountDistributedToWinners: json['amountDistributedToWinners'],
      amountTakenByAdmin: json['amountTakenByAdmin'],
      createdAt: json['created_at'],
      earnings: json['earnings'],
    );
  }
}

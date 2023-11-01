import 'package:flutter/material.dart';

class TradesTab extends StatefulWidget {
  const TradesTab({Key? key}) : super(key: key);

  @override
  _TradesTabState createState() => _TradesTabState();
}

class _TradesTabState extends State<TradesTab> {
  int _selectedIndex = 0;

  static const List<Widget> _tabs = <Widget>[
    Center(
      child: Text('Fixed Time'),
    ),
    Center(
      child: Text('Forex'),
    ),
    Center(
      child: Text('Fixed Time'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trading'),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              Tab(
                text: 'Fixed Time',
              ),
              Tab(
                text: 'Forex',
              ),
              Tab(
                text: 'Fixed Time',
              ),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserTable extends StatefulWidget {
  @override
  _UserTableState createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No User Data Found'),
            );
          } else {
            List<User> users = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
  columns: const [
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('User ID')),
    DataColumn(label: Text('Earnings')),
    DataColumn(label: Text('Created At')),
  ],
  rows: users.map<DataRow>((user) => DataRow(
    cells: [
      DataCell(Text(user.betResultId.toString())), // ID
      DataCell(Text(user.userId)), // User ID
      DataCell(Text(user.earnings)), // Earnings
      DataCell(Text(user.createdAt)), // Created At
    ],
  )).toList(),
),
            );
          }
        },
      ),
    );
  }
}

Future<List<User>> fetchUserData() async {
  final response = await http.get(
    Uri.parse('https://olyimtrade.wilatonprojects.com/get-bet-results'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = json.decode(response.body);
    // Since your API returns a single object, we create a User from the root object.
    User user = User.fromJson(jsonMap);
    // Return a list containing just our single user.
    return [user];
  } else {
    throw Exception('Failed to load user data');
  }
}

class User {
  final int betResultId;
  final String userId;
  final String earnings;
  final String createdAt;

  User({
    required this.betResultId,
    required this.userId,
    required this.earnings,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // Assuming 'id' from the JSON corresponds to 'betResultId' in your User model.
      betResultId: json['id'] as int, // If 'id' is an integer.
      userId: json['userId'] ?? 'Unknown', // Default value in case 'userId' is not provided.
      earnings: json['earnings'].toString(), // Convert to string, handle the case where earnings might be null or not a string.
      createdAt: json['created_at'],
    );
  }
}

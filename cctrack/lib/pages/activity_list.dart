import 'package:flutter/material.dart';

class ActivityListPage extends StatelessWidget {
  final List<String> activities = [
    "Event 1: Leadership Workshop",
    "Event 2: Startup Competition",
    "Event 3: Sports Meet"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracked Activities'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(activities[index]),
          );
        },
      ),
    );
  }
}

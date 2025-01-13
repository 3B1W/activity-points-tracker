import 'package:cctrack/pages/activity_list.dart';
import 'package:cctrack/pages/upload_page.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Point Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadCertificatePage()),
                );
              },
              child: const Text('Upload Activity'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityListPage()),
                );
              },
              child: const Text('View Activities'),
            ),
          ],
        ),
      ),
    );
  }
}

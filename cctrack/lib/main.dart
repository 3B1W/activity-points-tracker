import 'package:cctrack/pages/home_page.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/activity_list.dart';
import 'pages/certificate_list_page.dart';
 // Assuming these files contain defined pages
import 'package:flutter/material.dart';
import 'pages/upload_page.dart';
import 'package:cctrack/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  get set => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity Point Tracker',
      theme: lightMode, // Apply light mode as default theme
      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => const LoginPage(), // Login page route
        '/home': (context) => const DashboardPage (), // Home page route
        '/register': (context) => const SignUpPage(), // Sign-up page route
        '/upload': (context) =>  const UploadCertificatePage(), // Upload certificate page route
        '/certificate_list': (context) =>const CertificateListPage(tkmId: 220995),// Proper initialization for certificate list
        '/tracked_activities': (context) =>  ActivityListPage(), // Activity list page route
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> certificates = [
      {
        "title": "Metaverse - NITC TATHVA'22",
        "points": 15,
        "date": "Sunday, 12 June",
      },
      {
        "title": "Ethical Hacking Workshop Tryst'24 IIT Delhi",
        "points": 15,
        "date": "Sunday, 12 June",
      },
      {
        "title": "Programming, Data Structures and Algorithms using Python",
        "points": 50,
        "date": "Sunday, 12 June",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Point Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/certificate_list',
                    arguments: certificates); // Passing certificates as arguments
              },
              child: const Text('View Certificates'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
              child: const Text('Upload Certificate'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tracked_activities');
              },
              child: const Text('Activity List'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/saved_upload');
              },
              child: const Text('Saved Upload Page'),
            ),
          ],
        ),
      ),
    );
  }
}

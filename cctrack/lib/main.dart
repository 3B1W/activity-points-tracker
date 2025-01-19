import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/activity_list.dart';
import 'pages/certificate_list_page.dart';
import 'pages/upload_page.dart'; // Assuming these files contain defined pages
import 'themes/light_mode.dart'; // Assuming you have light_mode.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Fetch tkmId from SharedPreferences
  Future<int?> getTkmId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tkmId');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity Point Tracker',
      theme: lightMode, // Apply light mode as default theme
      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => const LoginPage(), // Login page route
        '/home': (context) => const HomePage(), // Home page route
        '/register': (context) => const SignUpPage(), // Sign-up page route
        '/upload': (context) => const UploadCertificatePage(), // Upload certificate page route
        '/tracked_activities': (context) => ActivityListPage(), // Activity list page route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/certificate_list') {
          return MaterialPageRoute(
            builder: (context) {
              // Fetch tkmId and pass it to the CertificateListPage
              return FutureBuilder<int?>(
                future: getTkmId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text("Error or No tkmId"));
                  } else {
                    int? tkmId = snapshot.data;
                    return CertificateListPage(tkmId: tkmId ?? 0); // Pass the tkmId
                  }
                },
              );
            },
          );
        }
        return null; // Return null if no matching route is found
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> certificates = [
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
                Navigator.pushNamed(
                  context,
                  '/certificate_list',
                  arguments: certificates, // Passing certificates as arguments
                );
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
          ],
        ),
      ),
    );
  }
}

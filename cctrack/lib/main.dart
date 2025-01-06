import 'package:flutter/material.dart';
import 'themes/theme_provider.dart';
import 'themes/light_mode.dart';
import 'themes/dark_mode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Light Mode Demo',
      theme: lightMode, // Apply the lightMode theme
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Mode Theme'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Button action (optional)
          },
          child: const Text('A Button'),
        ),
      ),
    );
  }
}

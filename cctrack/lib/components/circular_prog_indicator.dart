import 'package:flutter/material.dart';

class ScoreTracker extends StatelessWidget {
  final double scoreValue; // Dynamic score value from backend

  const ScoreTracker({super.key, required this.scoreValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200, // Adjust size for bigger circular tracker
            height: 200,
            child: CircularProgressIndicator(
              value: scoreValue / 100, // Normalize score to a range of 0 to 1
              strokeWidth: 20,
              backgroundColor: Colors.grey[200],
              color: Colors.pinkAccent, // Stylish accent color
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${scoreValue.toStringAsFixed(0)}', // Display score percentage
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 118, 3, 41),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Score Tracker',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 27, 5, 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

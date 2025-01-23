import 'package:flutter/material.dart';

// Custom Clipper to create a diagonal cut effect
class DiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top-left corner
    path.lineTo(0, 0);

    // Draw a diagonal line to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Draw a line back to the bottom-left corner
    path.lineTo(0, size.height);

    // Close the path by drawing a line to the starting point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;  // We don't need to reclip, so return false
  }
}

// Tile widget that uses the diagonal path clipper
class Tile extends StatelessWidget {
  const Tile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tile with Diagonal Cut")),
      body: Center(
        child: ClipPath(
          clipper: DiagonalPathClipper(),
          child: Container(
            width: 300,
            height: 200,
            color: Colors.blue,
            child: const Center(
              child: Text(
                "Clipped Tile",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Tile()));
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Points Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: const Color(0xFF002366), // Blue background for card
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'John Smith',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'CURRENT POINTS',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '55',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Staggered Grid Menu with Different Shapes
            Expanded(
              child: StaggeredGridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                staggeredTiles: const [
                  StaggeredTile.count(2, 2), // Profile and Edits
                  StaggeredTile.count(2, 1), // Activity Catalogue
                  StaggeredTile.count(1, 1), // Certificate List
                  StaggeredTile.count(1, 2), // Upload Certificate
                  StaggeredTile.count(2, 1), // Tracked Activity List
                  StaggeredTile.count(2, 1), // Earn Your Points
                ],
                children: [
                  _buildProfileandEditItem('Profile and Edits', 'lib/assets/Profile_and_edits.png'),
                  _builActiivityCatalogueItem('Activity Catalogue', 'lib/assets/Activity_catalogue.png'),
                  _buildCertificateListItem('Certificate List', 'lib/assets/Certificate_list.png'),
                  _buildUploadCertificateItem('Upload Certificate', 'lib/assets/Upload_certificate.png'),
                  _buildTrackedActivityItem('Tracked Activity List', 'lib/assets/Tracked_activity_list.png'),
                  _buildEarnPointsItem('Earn Your Points', 'lib/assets/Earn_your_points.png'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileandEditItem(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 120, fit: BoxFit.contain),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _builActiivityCatalogueItem(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 40, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildCertificateListItem(String title, String imagePath) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 40, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class StaggeredGridView {
}

Widget _buildUploadCertificateItem(String title, String imagePath) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 40, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

Widget _buildTrackedActivityItem(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 40, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
Widget _buildEarnPointsItem(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 40, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

class DiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 30, 0);
    path.lineTo(size.width, size.height - 30);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}*/
import 'dart:ui';
import 'package:cctrack/pages/activity_list.dart';
import 'package:cctrack/pages/certificate_list_page.dart';
import 'package:cctrack/pages/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04), // Adjust padding based on screen size
          child: Column(
            children: [
              // Points Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: height * 0.07, horizontal: width * 0.05),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF002366), Color.fromARGB(255, 71, 146, 232), Color.fromARGB(255, 19, 194, 213)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Smith',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'CURRENT POINTS',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '55',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Staggered Grid Menu with Different Sizes
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,  // Adjust this to increase vertical space
                crossAxisSpacing: 16, // Adjust this to increase horizontal space
                children: const [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Tile(index: 3),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Tile(index: 1),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 0),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 3,
                    child: Tile(index: 2),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 2,
                    child: Tile(index: 4),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 2,
                    child: Tile(index: 5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;

  const Tile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _buildProfileandEditItem('Profile and edits', 'lib/assets/Profile_and_edits.png', context);
      case 1:
        return _buildActivityCatalogueItem('Activity\nCatalogue', 'lib/assets/Activity_catalogue.png', context);
      case 2:
        return _buildCertificateListItem('Certificate\nList', 'lib/assets/Certificate_list.png', context);
      case 3:
        return _buildUploadCertificateItem('Upload\nCertificate', 'lib/assets/Upload_certificate.png', context);
      case 4:
        return _buildTrackedActivityItem('Tracked\nActivity\nList', 'lib/assets/Tracked_activity_list.png', context);
      case 5:
        return _buildEarnPointsItem('Earn Your Points', 'lib/assets/Earn_your_points.png', context);
      default:
        return Container();
    }
  }

  Widget _buildProfileandEditItem(String title, String imagePath, BuildContext context) {
    return _buildGridItem(title, imagePath, 150, context);
  }

  Widget _buildActivityCatalogueItem(String title, String imagePath, BuildContext context) {
    return _buildGridItem(title, imagePath, 40, context);
  }

  Widget _buildCertificateListItem(String title, String imagePath, BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: _buildGridItem(title, imagePath, 180, context),
    );
  }

  Widget _buildUploadCertificateItem(String title, String imagePath, BuildContext context) {
    return _buildGridItemWithCornerRadius(title, imagePath, 30, context);
  }

  Widget _buildTrackedActivityItem(String title, String imagePath, BuildContext context) {
    return _buildGridItemWithCornerRadius(title, imagePath, 80, context);
  }

  Widget _buildEarnPointsItem(String title, String imagePath, BuildContext context) {
    return _buildGridItemWithCornerRadius(title, imagePath, 90, context);
  }
Widget _buildGridItem(String title, String imagePath, double imageHeight, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (title == 'Profile and edits') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityListPage()),
        );
      } else if (title == 'Activity\nCatalogue') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityListPage()), // Replace with your actual page
        );
      } else if (title == 'Certificate\nList') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CertificateListPage(tkmId: 220995,)), // Replace with your actual page
        );
      } else if (title == 'Upload\nCertificate') {
        
            Navigator.pushNamed(context, '/upload'); // Replace with your actual page
        
      } else if (title == 'Tracked\nActivity\nList') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityListPage()), // Replace with your actual page
        );
      } else if (title == 'Earn Your Points') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityListPage()), // Replace with your actual page
        );
      }
    },
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: imageHeight, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}
  Widget _buildGridItemWithCornerRadius(String title, String imagePath, double imageHeight, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to corresponding page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlaceholderPage(title: title)), // Replace PlaceholderPage with your actual pages
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: imageHeight, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// Placeholder page for navigation
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('This is the $title page.')),
    );
  }
}

class DiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 30, 0);
    path.lineTo(size.width, size.height - 30);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


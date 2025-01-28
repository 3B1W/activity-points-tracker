import 'package:cctrack/models/StudentDto.dart';
import 'package:cctrack/models/backend_url.dart';
import 'package:cctrack/pages/User_Profile_Page.dart';
import 'package:cctrack/pages/setting_page.dart';
import 'package:cctrack/service/api_backend_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cctrack/pages/activity_list.dart';
import 'package:cctrack/pages/upload_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final apiBackendService = ApiBackendService(baseUrl: BASE_URL);
  late Future<Student> futureStudent;
  late int tkmId;

  String name = ''; // For storing student's name
  int points = 0; // For storing student's points
  String fname = '';
  String lname= '';
  int regno = 0;
  String email = '';
  String roll = '';
  int year=0;

  @override
  void initState() {
    super.initState();
    _fetchStudentDetails();
  }

  // Fetch tkmId and student details
  Future<void> _fetchStudentDetails() async {
    try {
      tkmId = (await apiBackendService.getTkmId())!; // Fetch tkmId
      futureStudent = apiBackendService.fetchStudentDetails(tkmId); // Fetch student details
      final student = await futureStudent; // Wait for future to resolve
      setState(() {
        name = '${student.firstName} ${student.lastName}'; // Update name from fetched details
        points = student.actpts ?? 0; // Default to 0 if null
        fname = student.firstName.isNotEmpty ? student.firstName : 'Unknown';
        lname = student.lastName.isNotEmpty ? student.lastName : 'Unknown';
        regno = student.tkmId;
        email = student.email.isNotEmpty ? student.email : 'N/A';
        roll = student.rollNo?.isNotEmpty == true ? student.rollNo! : 'N/A';
        year = student.year ?? 0;
      });
    } catch (e) {
      print('Error fetching student details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var selectedIndex = 0;

    return WillPopScope(
      onWillPop: () async {
        // This will exit the app
        SystemNavigator.pop();
        return false; // Prevent the default back action
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: const Icon(Icons.notifications_none, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.35,
                  padding: EdgeInsets.symmetric(vertical: height * 0.04, horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF002366), Color(0xFF4792E8), Color.fromARGB(255, 116, 223, 153)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name.isEmpty ? 'Loading...' : name, // Dynamically display student's name
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'CURRENT POINTS',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontFamily: 'Poppins-Italic.ttf',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.26, // Adjust size of the indicator
                            height: width * 0.26,
                            child: CircularProgressIndicator(
                              value: points / 100, // Normalize score to a range of 0 to 1
                              strokeWidth: 20, // Thickness of the progress bar
                              backgroundColor: Color.fromARGB(255, 199, 236, 244),
                              color: Color.fromARGB(255, 0, 123, 255),
                              strokeCap: StrokeCap.round,// Stylish accent color
                            ),
                          ),
                          Text(
                            points.toString(), // Display points in the center
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: width * 0.02,
                  crossAxisSpacing: width * 0.02,
                  children: const [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile(index: 0),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: Tile(index: 3),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: Tile(index: 4),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: Tile(index: 2),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: Tile(index: 5),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Tile(index: 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex, // Track selected index
          onTap: (index) {
            setState(() {
              selectedIndex = index; // Update selected index on tap
            });
            if(index==1){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Log Out',
            ),
          ],
        ),
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
        return _buildTile('Profile and edits', 'lib/assets/Profile_and_edits.png',
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfilePage(
                    ),
                  ),
                ));
      case 2:
        return _buildTile('Activity\nCatalogue', 'lib/assets/Activity_catalogue.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityListPage()),
                ));
      case 1:
        return _buildTile('Certificate List', 'lib/assets/Certificate_list.png',
            () => Navigator.pushNamed(
                  context,
                  '/certificate_list', // Use the named route
                ));
      case 3:
        return _buildTile('Upload', 'lib/assets/Upload_certificate.png',
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadCertificatePage()),
                ));
      case 4:
        return _buildTile('Tracked\nActivity\nList', 'lib/assets/Tracked_activity_list.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityListPage()),
                ));
      case 5:
        return _buildTile('Earn Your\nCredits', 'lib/assets/Earn_your_points.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityListPage()),
                ));
      default:
        return Container();
    }
  }

  Widget _buildTile(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 90, fit: BoxFit.contain),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis, // Prevents text from overflowing
              ),
            ),
          ],
        ),
      ),
    );
  }
}

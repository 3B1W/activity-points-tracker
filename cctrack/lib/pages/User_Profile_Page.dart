import 'package:cctrack/models/StudentDto.dart';
import 'package:cctrack/models/backend_url.dart';
import 'package:cctrack/service/api_backend_service.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController registerNoController;
  late TextEditingController emailController;
  late TextEditingController rollNoController;
  late TextEditingController yearController;

  bool isEditing = false; // To track whether the user is editing the profile

  //STUDENT DATA
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
    // Setting random placeholder data
    firstNameController = TextEditingController(text: fname.isNotEmpty ? fname : '');
    lastNameController = TextEditingController(text: lname.isNotEmpty ? lname : '');
    registerNoController = TextEditingController(text: regno != 0 ? '$regno' : '');
    emailController = TextEditingController(text: email.isNotEmpty ? email : '');
    rollNoController = TextEditingController(text: roll.isNotEmpty ? roll : '');
    yearController = TextEditingController(text: year != 0 ? '$year' : '');
  }

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

          // Update controllers with new data
          firstNameController.text = fname;
          lastNameController.text = lname;
          registerNoController.text = regno != 0 ? '$regno' : '';
          emailController.text = email;
          rollNoController.text = roll;
          yearController.text = year != 0 ? '$year' : '';
        });
      } catch (e) {
        print('Error fetching student details: $e');
      }
    }
  void updateDetails() async {
  final result = await ApiBackendService(baseUrl: BASE_URL).updateStudentDetails(
    tkmId: tkmId,
    firstName: firstNameController.text,
    lastName: lastNameController.text,
    regno: int.tryParse(registerNoController.text),
    email: emailController.text,
    rollNo: rollNoController.text,
    year: yearController.text,
  );

  if (result['success']) {
    print('Profile updated successfully!');
    tkmId = int.tryParse(registerNoController.text) ?? tkmId; // Update tkmId with regNo if same
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
    
    // Fetch updated student details
    _fetchStudentDetails(); // Reload student details after update
  } else {
    print('Error updating profile: ${result['error']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update profile: ${result['error']}')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/a8/4a/a3/a84aa310f33862e53c30f55bdf94b013.jpg'), // Placeholder image URL
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: firstNameController,
              label: 'First Name',
              hint: 'Enter your first name',
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: lastNameController,
              label: 'Last Name',
              hint: 'Enter your last name',
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: registerNoController,
              label: 'Register No.',
              hint: 'e.g. 220456',
              keyboardType: TextInputType.number,
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: emailController,
              label: 'Email Address',
              hint: 'name@email.com',
              keyboardType: TextInputType.emailAddress,
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: rollNoController,
              label: 'Roll No.',
              hint: 'Enter your roll number',
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.025),
            _buildTextField(
              controller: yearController,
              label: 'Year',
              hint: 'Enter your year',
              enabled: isEditing,
            ),
            SizedBox(height: screenHeight * 0.035),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    // Save changes logic here
                    updateDetails();
                    print("Profile saved");
                    
                  }
                  isEditing = !isEditing; // Toggle editing mode
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.surface,
                backgroundColor: theme.colorScheme.primary,
                minimumSize: Size(screenWidth * 0.8, screenHeight * 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Text(
                isEditing ? 'Save Profile' : 'Edit Profile',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),
              suffixIcon: suffixIcon,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            enabled: enabled,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    registerNoController.dispose();
    emailController.dispose();
    rollNoController.dispose();
    yearController.dispose();
    super.dispose();
  }
}

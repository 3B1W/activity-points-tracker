import 'package:cctrack/themes/dark_mode.dart';
import 'package:cctrack/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadCertificatePage extends StatefulWidget {
  const UploadCertificatePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UploadCertificatePageState createState() => _UploadCertificatePageState();
}

class _UploadCertificatePageState extends State<UploadCertificatePage> {
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedLevelOrRole;

  final Map<String, List<String>> subCategories = {
    'Entrepreneurship & Innovation': [
      'Products Developed',
      'Start-up Company (Registered legally)',
      'Patent-Filed',
      'Patent-Published',
      'Patent-Approved',
      'Patent-Licensed',
      'Prototype developed and tested',
      'Awards for Products developed',
      'Innovative Technologies (Developed and used by industries/users)',
      'Got Venture Capital Funding (For innovative ideas/products)',
      'Startup Employment',
      'Societal Innovations',
    ],
    'Leadership & Management': [
      'Core Coordinator',
      'Sub Coordinator',
      'Volunteer',
    ],
    'National Initiatives Participation': [
      'NCC',
      'NSS',
    ],
    'Sports & Games Participation': [
      'Participation',
      'First Prize',
      'Second Prize',
      'Third Prize',
    ],
    'Cultural Activities Participation': [
      'Music',
      'Performing Arts',
      'Literary Arts',
      'Participation',
      'First Prize',
      'Second Prize',
      'Third Prize',
    ],
    'Professional Self Initiatives': [
      'Conference/Seminar Attendance (IITs/NITs)',
      'Paper Presentation/Publication (IITs/NITs)',
      'Poster Presentation/Publication (IITs/NITs)',
      'Industrial Training/Internship (5+ days)',
      'Industrial/Exhibition Visits',
      'Foreign Language Skill (TOEFL/IELTS/BEC)',
      'MOOC with Final Assessment Certificate',
      'Tech Fest',
      'Competitions by Professional Bodies',
    ],
  };

  final Map<String, List<String>> rolesLevels = {
    'Participation': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'First Prize': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Second Prize': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Third Prize': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Music': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Performing Arts': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Literary Arts': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Tech Fest': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
    'Competitions by Professional Bodies': ['Level I', 'Level II', 'Level III', 'Level IV', 'Level V'],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: screenWidth * 0.03,  // Smaller font size
        ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.tertiary,
        actions: [
          IconButton(
            icon: Icon(
              theme.colorScheme.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(darkMode);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // Made the page scrollable
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),  // Reduced horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Certificate',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,  // Even smaller title font size
                ),
              ),
              Text(
                "Enter the category details",
                  style: TextStyle(
                  fontSize: screenWidth * 0.025,  // Smaller description font size
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 8),

              _buildTextField(label: "Event name", hintText: "Name", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 8),
              _buildDropdownField1(label: "Category", hintText:"categories", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 8),
              if (_selectedCategory != null)
                _buildDropdownField2(label: "Sub-Category", hintText:"sub-categories", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 8),
              if (_selectedSubCategory != null)
                _buildDropdownField3(label: "Level or Role", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 8),
              _buildTextField(label: "Certificate link", hintText: "Drive link", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 8),
              _buildTextField(label: "Duration or Specific date", hintText:"eg.2 years" ,theme:theme, screenWidth: screenWidth),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.surface,
                    minimumSize: Size(screenWidth * 0.22, screenHeight * 0.09), // Smaller button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),  // Further reduced border radius
                    ),
                  ),
                  onPressed: () {
                    // Handle submission action
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: screenWidth * 0.03),  // Even smaller button text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hintText,
    required ThemeData theme,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),  // Reduced padding inside text fields
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.025,  // Smaller label font size
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: TextStyle(
              fontSize: screenWidth * 0.025,  // Ensure typed text matches hint text size
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.tertiary, // Matches the hint text color
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: screenWidth * 0.025,  // Smaller hint text font size
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),  // Reduced padding inside box
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),  // Reduced border radius
                borderSide: BorderSide(
                color: theme.colorScheme.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField1({
    required String label,
    required String hintText,
    required ThemeData theme,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),  // Reduced padding inside dropdowns
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.025,  // Smaller label font size
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: subCategories.keys
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,  // Smaller dropdown item font size
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
                _selectedSubCategory = null;
                _selectedLevelOrRole = null;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),  // Reduced padding inside box
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),  // Reduced border radius
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField2({
    required String label,
    required ThemeData theme,
    required String hintText,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),  // Reduced padding inside dropdowns
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.025,  // Smaller font size for labels
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedSubCategory,
            items: subCategories[_selectedCategory!]!
                .map((String value) => DropdownMenuItem<String>(  
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,  // Smaller font size for dropdown items
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedSubCategory = value;
                _selectedLevelOrRole = null;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),  // Reduced padding inside box
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),  // Reduced border radius
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField3({
    required String label,
    required ThemeData theme,
    required double screenWidth,
  }) {
    if (_selectedSubCategory == null ||
        !rolesLevels.containsKey(_selectedSubCategory!)) return SizedBox();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),  // Reduced padding inside dropdowns
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.025,  // Smaller font size for labels
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedLevelOrRole,
            items: rolesLevels[_selectedSubCategory!]!
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,  // Smaller font size for dropdown items
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedLevelOrRole = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),  // Reduced padding inside box
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),  // Reduced border radius
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cctrack/models/backend_url.dart';
import 'package:cctrack/models/categories_list.dart';
import 'package:cctrack/models/certificatedto_model.dart';
import 'package:cctrack/service/api_backend_service.dart';
import 'package:cctrack/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadCertificatePage extends StatefulWidget {
  const UploadCertificatePage({super.key});

  @override
  _UploadCertificatePageState createState() => _UploadCertificatePageState();
}

class _UploadCertificatePageState extends State<UploadCertificatePage> {
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedLevelOrRole;

  // Text controllers to capture the input from text fields
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController certificateLinkController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  //api service
  final apiService = ApiBackendService(baseUrl: BASE_URL); //192.168.221.150

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
          fontSize: screenWidth * 0.05,  // Larger font size
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
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // Made the page scrollable
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),  // Increased horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Certificate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,  // Larger title font size
                  fontFamily: 'Poppins-Bold'
                ),
              ),
              Text(
                "Enter the category details",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,  // Larger description font size
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.inversePrimary,
                  fontFamily: 'Poppins-Regular'
                ),
              ),
              const SizedBox(height: 12),

              _buildTextField(label: "Event name", hintText: "Name", theme: theme, screenWidth: screenWidth, controller: eventNameController),
              const SizedBox(height: 12),
              _buildDropdownField1(label: "Category", hintText:"categories", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 12),
              if (_selectedCategory != null)
                _buildDropdownField2(label: "Sub-Category", hintText:"sub-categories", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 12),
              if (_selectedSubCategory != null)
                _buildDropdownField3(label: "Level or Role", theme: theme, screenWidth: screenWidth),
              const SizedBox(height: 12),
              _buildTextField(label: "Certificate link", hintText: "Drive link", theme: theme, screenWidth: screenWidth,controller: certificateLinkController),
              const SizedBox(height: 12),
              _buildTextField(label: "Duration or Specific date", hintText:"eg.2 years" ,theme:theme, screenWidth: screenWidth,controller: durationController),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft, 
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.surface,
                    minimumSize: Size(screenWidth * 0.3, screenHeight * 0.05), // Larger button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),  // Slightly larger border radius
                    ),
                  ),
                  onPressed: () async {

                    final tkmid = await apiService.getTkmId();
                    final autht = await apiService.getAuthToken();
                    print(tkmid);
                    // Handle submission action
                    print('Event Name: ${eventNameController.text}');
                    print('Cert-link: ${certificateLinkController.text}');
                    print('duration: ${durationController.text}');
                    print(autht);
                    //print((certificateLinkController.text.runtimeType));
                    final certificateDTO = CertificateDTO(
                      eventName: eventNameController.text,
                      category: _selectedCategory,
                      subCategory: _selectedSubCategory,
                      levelRole: _selectedLevelOrRole,
                      certificateLink: certificateLinkController.text,
                      duration: durationController.text,
                    );
                    if (certificateDTO.eventName.isEmpty || certificateDTO.certificateLink.isEmpty || certificateDTO.duration.isEmpty) {
                      // Show an error message if any required field is empty
                      print('Please fill all fields');
                      return;
                    }
                    final response = await apiService.uploadCertificate(tkmid!, eventNameController.text, _selectedCategory, _selectedSubCategory, _selectedLevelOrRole, certificateLinkController.text, durationController.text);
                    // Check if the response status is 201 Created
                  if (response.statusCode == 201 || response.statusCode == 200) {
                    print('Certificate submitted successfully');
                    
                    // Show a success message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Success"),
                        content: const Text("Your certificate has been submitted."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Navigate to the Certificate List page
                              Navigator.pushReplacementNamed(context, '/certificate_list');
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Handle other status codes or errors
                    print('Failed to submit certificate. Status: ${response.statusCode}');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Error"),
                        content: const Text("There was an issue submitting your certificate. Please try again."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: screenWidth * 0.04),  // Larger button text
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
      required TextEditingController controller,
    }) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.tertiary,
              ),
              maxLines: null, // Allow text to expand vertically
              minLines: 1, // Minimum one line
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 2.0),
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
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          isExpanded: true, // Ensure dropdown fills available width
          items: subCategories.keys
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
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
            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildDropdownField2({
  required String label,
  required String hintText,
  required ThemeData theme,
  required double screenWidth,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedSubCategory,
          isExpanded: true, // Ensure dropdown fills available width
          items: subCategories[_selectedCategory!]!
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
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
            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
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
  if (_selectedSubCategory == null || !rolesLevels.containsKey(_selectedSubCategory!)) return const SizedBox();

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedLevelOrRole,
          isExpanded: true, // Ensure dropdown fills available width
          items: rolesLevels[_selectedSubCategory!]!
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
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
            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
          ),
        ),
      ],
    ),
  );
}


}

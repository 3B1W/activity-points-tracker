// import 'dart:convert';
// import 'package:cctrack/certificate_detail_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:cctrack/models/certificate_model.dart';
// import 'package:cctrack/themes/dark_mode.dart';
// import 'package:cctrack/themes/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CertificateListPage extends StatelessWidget {
//   final int tkmId;

//   const CertificateListPage({required this.tkmId, super.key});

//   // Fetch Certificates from API
//   Future<List<Certificate>> fetchCertificates(int tkmId) async {
//     final url = Uri.parse('http://192.168.29.100:8080/api/certificate/all/$tkmId');
//     final response = await http.get(url);
//     print('Response: ${response.body}');

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Certificate.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch certificates');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Certificate List",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: screenWidth * 0.035, // Increased font size for title
//           ),
//         ),
//         backgroundColor: theme.colorScheme.surface,
//         foregroundColor: theme.colorScheme.tertiary,
//       ),
//       body: FutureBuilder<List<Certificate>>(
//         future: fetchCertificates(tkmId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No certificates found'));
//           }

//           final certificates = snapshot.data!;
//           return ListView.builder(
//             itemCount: certificates.length,
//             itemBuilder: (context, index) {
//               return CertificateCard(certificate: certificates[index]);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Certificate Card
// class CertificateCard extends StatelessWidget {
//   final Certificate certificate;

//   const CertificateCard({required this.certificate, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03), // Increased horizontal padding
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         elevation: 3, // Increased elevation for better shadow effect
//         child: Padding(
//           padding: const EdgeInsets.all(20), // Increased padding for more space
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 certificate.eventName,
//                 style: theme.textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenWidth * 0.04, // Increased font size
//                 ),
//               ),
//               const SizedBox(height: 12), // Increased spacing
//               Text(
//                 "Points: ${certificate.pointsEarned}",
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.035, // Increased font size
//                   color: theme.colorScheme.inversePrimary,
//                 ),
//               ),
//               const SizedBox(height: 12), // Increased spacing
//               Divider(
//                 color: theme.colorScheme.inversePrimary,
//                 thickness: 1, // Increased thickness for a more prominent divider
//               ),
//               const SizedBox(height: 12), // Increased spacing
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_today, size: 18), // Slightly larger icon
//                   const SizedBox(width: 12), // Increased spacing
//                   Text(
//                     certificate.durationDate,
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.035, // Increased font size
//                       fontWeight: FontWeight.bold,
//                       color: theme.colorScheme.inversePrimary,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20), // Increased spacing before button
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   backgroundColor: Colors.blue[50],
//                   foregroundColor: theme.colorScheme.primary,
//                   minimumSize: const Size(double.infinity, 55), // Increased button size
//                 ),
//                 onPressed: () {
//                   // Add navigation or details viewing action here
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CertificateDetailPage(
//                         certificate: certificate, // Passing the object directly
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("Detail", style: TextStyle(fontSize: 18)), // Button text size remains the same
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

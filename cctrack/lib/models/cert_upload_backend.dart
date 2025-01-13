import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> uploadCertificate(
  int tkmId,
  String eventName,
  String? category,
  String? subCategory,
  String? levelRole,
  String certificateLink,
  String duration,
) async {
  const url = 'http://192.168.226.150:8080/api/certificate/upload'; // Replace with your backend URL

  // Creating the payload (request body)
  final Map<String, dynamic> requestBody = {
    'tkmId': tkmId,
    'eventName': eventName,
    'category': category,
    'subCategory': subCategory,
    'levelRole': levelRole,
    'proofCertificate': certificateLink,
    'durationDate': duration,
  };

  try {
    // Sending the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    // Return the response so it can be handled by the calling code
    return response;
  } catch (e) {
    // Handle errors
    print('Error: $e');
    // Return a failed response with status code 500 if there is an error
    return http.Response('Error: $e', 500);
  }
}

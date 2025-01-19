import 'dart:convert';
import 'package:cctrack/models/certificate_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBackendService {
  final String baseUrl;

  ApiBackendService({required this.baseUrl});

  /// Sign up a new user
  Future<Map<String, dynamic>> signup(String firstName, String lastName, String email, String password, String regNo) async {
    final url = Uri.parse('$baseUrl/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'tkmId': int.parse(regNo),
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'error': jsonDecode(response.body)['error']};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Log in an existing user
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // Save token, studentId, and tkmId to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', body['accessToken']);
        prefs.setInt('studentId', body['studentId']);
        prefs.setInt('tkmId', body['tkmId']);

        return {'success': true, 'token': body['accessToken']};
      } else {
        return {'success': false, 'error': jsonDecode(response.body)['error']};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Get TKM ID from SharedPreferences
  Future<int?> getTkmId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tkmId');
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Upload a certificate
  Future<http.Response> uploadCertificate(
    int tkmId,
    String eventName,
    String? category,
    String? subCategory,
    String? levelRole,
    String certificateLink,
    String duration
  ) async {
    final url = Uri.parse('$baseUrl/api/certificate/upload'); // Ensure the baseUrl is correct

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
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      return response;
    } catch (e) {
      // Handle errors
      print('Error: $e');
      // Return a failed response with status code 500 if there is an error
      return http.Response('Error: $e', 500);
    }
  }

  /// Fetch certificates for a given TKM ID
  Future<List<Certificate>> fetchCertificates(int tkmId) async {
    final url = Uri.parse('$baseUrl/api/certificate/all/$tkmId');
    final response = await http.get(url);
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Certificate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch certificates');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl;

  AuthRepository(this.baseUrl);



  // login


  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers:<String, String> {'Content-Type': 'application/json'},
      body: json.encode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {

      var data = jsonDecode(response.body);
      return {
        'token':data['token']
      }; // Return the entire response map
    } else {
      print('Failed to signup: ${response.statusCode} ${response.body}');
      throw Exception('Failed to signup with status code ${response.statusCode}');
    }
  }



  // signup


  Future<String> signup(String fullname, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'fullname': fullname, 'email': email, 'password': password}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('api response: $data');
      return data['token']; // Assume the token is directly returned upon successful registration
    } else {
      print('Failed to signup with status code ${response.statusCode} and body ${response.body}');
    throw Exception('Failed to signup with status code ${response.statusCode}');
    }
  }


  Future<Map<String, dynamic>> fetchUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch user details with status code ${response.statusCode}');
    }
  }

  Future<void> updateUserDetails(String token, String userId, String name, String email, String password) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'fullname': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user details  ${response.statusCode}');
    }
  }

}

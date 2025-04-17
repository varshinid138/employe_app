import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String apiUrl = 'https://reqres.in/api/users?page=2';

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl)).timeout(
  const Duration(seconds: 10),
);


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List users = data['data'];
      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

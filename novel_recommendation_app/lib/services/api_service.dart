import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  // ---------- AUTH ----------

  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)["detail"]);
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Invalid email or password");
    }
  }

  // ---------- NOVELS ----------

  static Future<List<dynamic>> fetchAllNovels() async {
    final response = await http.get(
      Uri.parse("$baseUrl/novels"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load novels");
    }
  }

  // ---------- GENRES ----------

  static Future<void> saveUserGenres(
    int userId,
    List<String> genres,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/$userId/genres"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"genres": genres}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to save genres");
    }
  }
}

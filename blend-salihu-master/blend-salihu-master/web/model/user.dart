import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String password;

  User(this.username, this.password);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  static Future<void> registerUser(
      String username, String password, int atLevel) async {
    final response = await http.post(
      Uri.parse('https://webapp-10260.edu.k8s.th-luebeck.dev/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
        'atLevel': atLevel,
      }),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      print('User registration failed');
    }
  }

  static Future<void> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://webapp-10260.edu.k8s.th-luebeck.dev/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User logged in successfully');
    } else if (response.statusCode == 401) {
      print('Invalid username or password');
    } else {
      print('User login failed');
    }
  }

  static Future<void> deleteUser(String username, String password) async {
    final response = await http.delete(
      Uri.parse('https://webapp-10260.edu.k8s.th-luebeck.dev/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else if (response.statusCode == 401) {
      print('Invalid username or password');
    } else {
      print('User deletion failed');
    }
  }

  static Future<void> updateUsername(
      String oldusername, String newusername, String password) async {
    final response = await http.put(
      Uri.parse('https://webapp-10260.edu.k8s.th-luebeck.dev/update_username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'old_username': oldusername,
        'new_username': newusername,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Username updated successfully');
    } else if (response.statusCode == 401) {
      print('Invalid old username or password');
    } else {
      print('Username update failed');
    }
  }

  static Future<void> updatePassword(
      String oldpassword, String newpassword, String username) async {
    final response = await http.put(
      Uri.parse('https://webapp-10260.edu.k8s.th-luebeck.dev/update_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'old_password': oldpassword,
        'new_password': newpassword,
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      print('Password updated successfully');
    } else if (response.statusCode == 401) {
      print('Invalid old username or password');
    } else {
      print('Username update failed');
    }
  }
}
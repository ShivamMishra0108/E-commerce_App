import 'dart:convert';

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/services/manage_http_responses.dart';
import 'package:e_commerce_app/views/screens/auth_screens/login_screen.dart';
import 'package:e_commerce_app/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  void showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }

  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user
            .toJson(), // Convert the user object to json for the request body
        headers: <String, String>{
          // Set the headers to the request
          "content-type":
              "application/json; charset=UTF-8", // specify the context type as json
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          showSnackBar(context, "Account has been created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  // signinusers function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      print('Sending signin request...');

      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Handle thr response using the ManageHttpResponse

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          showSnackBar(context, "Logged in successfully");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}

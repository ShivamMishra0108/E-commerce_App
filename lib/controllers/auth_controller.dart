import 'dart:convert';

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/services/manage_http_responses.dart';
import 'package:e_commerce_app/views/screens/auth_screens/login_screen.dart';
import 'package:e_commerce_app/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

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
        body: jsonEncode(user.toJson()),
        // Convert the user object to json for the request body

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
        onSuccess: () async {
          // Access sharedPreference for auth token and user data storage:
          SharedPreferences preferencres =
              await SharedPreferences.getInstance();

          // Extract te auth token from the response body:
          String token = jsonDecode(response.body)['token'];

          //Store the auth token securely in shaered preferences:
          await preferencres.setString('auth_token', token);

          // Encode the user fdata recideved from backend as json:
          String userJson = jsonEncode(jsonDecode(response.body)['user']);

          //Update the application state with user data from riverpod:
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //Store the data in hsaredPreferences for future use:
          await preferencres.setString('user', userJson);

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

  // SignOut

  Future<void> signOutUser({required, context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // Clear the token and user from shared preferences:
      preferences.remove('auth_token');
      preferences.remove('user');

      // Clear the user data
      providerContainer.read(userProvider.notifier).signOut();

      // Navigate to login screen

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );

      showSnackBar(context, "SignOut Successfulle");
    } catch (e) {
      showSnackBar(context, "Error SigninOut");
    }
  }

  Future<void> updateUserLocation({
    required context,
    required id,
    required state,
    required city,
    required locality,
  }) async {
    try {
      final http.Response response = await http.put(
        Uri.parse('$uri/api/user/$id'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({'state': state, 'city': city, 'locality': locality}),
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          final updatedUser = jsonDecode(response.body);

          SharedPreferences preferences = await SharedPreferences.getInstance();

          final userJson = jsonEncode(updatedUser);

          providerContainer.read(userProvider.notifier).setUser(userJson);

          await preferences.setString('user', userJson);
        },
      );
    } catch (e) {
      showSnackBar(context, "Error updating location");
    }
  }
}

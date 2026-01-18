import 'dart:convert';

//import 'package:flutter/material.dart';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  // Serializaton: Convert user object into a Map
  //MAP: A map is a collection of key-value pairs\
  // WHY: Converting to a map is an intemediate step to make easier to serialize
  // the object to formates like json for storage or transmission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token,
    };
  }

  // Sriealization: Convert the Map into the json String
  // This method directly encodes the data from map to json String

  // The json.encode() function converts a dart object(Map or List) into json String
  //represantation making it suitable to comunicate b/w different systems.
  String toJson() => json.encode(toMap());

  // DESERIALIZATION: Convert a map into user object so that it can be easily mamipulated and used within the app.
  // PURPOSE: Used to display the data the UI or to store the data locally.

  //FACTORY: It is a construtoer that takes the map and convert it into the user object.

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      locality: map["locality"] as String? ?? "",
      password: map["password"] as String? ?? "",
      token: map["token"] as String? ?? "",
    );
  }

  //fromJson:  This factory constructor takes json String and decodes into a map<String, dynamic>
  // and then uses fromMap to convert the map into user object.

  // factory User.fromJson(String source) =>
  //     User.fromMap(json.decode(source) as Map<String, dynamic>);

  factory User.fromJson(dynamic source) {
  if (source is String) {
    return User.fromMap(json.decode(source));
  } else if (source is Map<String, dynamic>) {
    return User.fromMap(source);
  } else {
    throw Exception('Invalid user data');
  }
}

}

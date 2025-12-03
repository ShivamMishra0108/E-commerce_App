import 'dart:convert';

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BannerController {

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners = data
            .map((banner) => BannerModel.fromJson(banner))
            .toList();

        return banners;
      } else {
        throw Exception("Failed to load banner");
      }
    } catch (e) {
      throw Exception("Error loading banners $e");
    }
  }
}

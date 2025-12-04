import 'dart:convert';
import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerController {

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-banner'),
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

  Future<BannerModel?> loadNewBanner() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-new-banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return BannerModel.fromJson(data);
      } else {
        print("No new banner found or error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error loading new banner: $e");
      return null;
    }
  }
}

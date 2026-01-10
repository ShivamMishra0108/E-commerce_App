import 'dart:convert';

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;


class ProductController {


  // GET ALL PRODUCTS:
  Future<List<Product>> loadAllProducts()async{
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/get-products'),
      headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        
          List<Product> products = data
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList();
          
          return products;
      }else{
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Failed Loading Product: $e");
    }
  }



  // GET PRODUCTS:
   Future<List<Product>> loadProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-products'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<Product> products = data
            .map((category) => Product.fromJson(category))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }




// GET POPULAR PEODUCTS:
Future<List<Product>> getPopularProduct() async {
  try {
    http.Response response = await http.get(
      Uri.parse("$uri/api/popular-products"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      List<Product> products = data.map((productJson) {
        Map<String, dynamic> map = productJson as Map<String, dynamic>;

        // Prepend backend URL to each image
        List<String> fullImages = (map['images'] as List<dynamic>)
            .map((img) => "$uri/uploads/$img")
            .toList();

        map['images'] = fullImages;
        return Product.fromJson(map);
      }).toList();

      return products;
    } else {
      throw Exception("Failed to load popular products");
    }
  } catch (e) {
    throw Exception("Failed loading popular products: $e");
  }
}

// GET PRODUCTS BY CATEGORY:
Future<List<Product>> getProductByCategory(String category)async{
  try {
    http.Response response = await http.get(Uri.parse("$uri/api/products-by-category/$category"),
     headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      List<Product> products = data.map((productJson) {
        Map<String, dynamic> map = productJson as Map<String, dynamic>;

        // Prepend backend URL to each image
        List<String> fullImages = (map['images'] as List<dynamic>)
            .map((img) => "$uri/uploads/$img")
            .toList();

        map['images'] = fullImages;
        return Product.fromJson(map);
      }).toList();

      return products;
    } else {
      throw Exception("Failed to load popular products");
    }
  } catch (e) {
    throw Exception("Failed loading popular products: $e");

  }
}

}
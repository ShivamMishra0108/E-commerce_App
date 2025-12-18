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




  // GET POPULAR PRODUCTS:
  // Future<List<Product>> getPopularProduct()async{
  //  try {
  //     http.Response response = await http.get(Uri.parse("$uri/api/get-products"),
  //     headers: <String, String>{
  //         "Content-Type": "application/json; charset=UTF-8",
  //       },
  //     );
      
  //     if(response.statusCode == 200){
  //       final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        
  //         List<Product> products = data
  //         .map((product) => Product.fromJson(product as Map<String, dynamic>))
  //         .toList();
          
  //         return products;
  //     }else{
  //       throw Exception("Failed to load products");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed Loading Product: $e");
  //   }
  // }
}
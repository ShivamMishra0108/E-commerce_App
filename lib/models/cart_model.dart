// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_serializable/json_serializable.dart';

class Cart {
  final String productName;
  final int productPrice;
  final String productId;
  final int productQuantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final List<String> image;
   final double averageRating;
   int quantity;

  Cart({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.image,
    required this.averageRating,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'productId': productId,
      'productQuantity': productQuantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'image': image,
      'averageRating': averageRating,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      productId: map['productId'] as String,
      productQuantity: map['productQuantity'] as int,
      description: map['description'] as String,
      category: map['category'] as String,
      vendorId: map['vendorId'] as String,
      fullName: map['fullName'] as String,
      image: List<String>.from((map['image'] as List<String>)),
      averageRating: map['averageRating'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}

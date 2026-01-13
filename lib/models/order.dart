import 'dart:convert';

class Order {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productName;
  final int productPrice;
  final int quantity;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;

  Order({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.image,
    required this.buyerId,
    required this.vendorId,
    required this.processing,
    required this.delivered,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
       'city': city,
      'locality': locality,
      'productName': productName,
      'productPrice': productPrice,
       'quantity': quantity,
      'category': category,
      'image': image,
      'buyerId': buyerId,
       'vendorId': vendorId,
      'processing': processing,
      'delivered': delivered,
    };
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      fullName: map['categoryId'] ?? '',
      email: map['image'] ?? '',
      state: map['categoryName'] ?? '',
      city: map['subCategoryName'] ?? '',
       locality: map['_id'] ?? '',
      productName: map['categoryId'] ?? '',
      productPrice: map['image'] ?? '',
      quantity: map['categoryName'] ?? '',
      category: map['subCategoryName'] ?? '',
       image: map['_id'] ?? '',
      buyerId: map['categoryId'] ?? '',
      vendorId: map['image'] ?? '',
      processing: map['categoryName'] ?? '',
       delivered: map['_id'] ?? '',
      );
  }

  String toJson() => json.encode(toMap());
}

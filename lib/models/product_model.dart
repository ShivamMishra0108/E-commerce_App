// TODO Implement this library.
import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;
  final double averageRating;
  final int totalRatings;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.subCategory,
    required this.images,
    required this.averageRating,
    required this.totalRatings,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'images': images,
      'averageRating':averageRating,
      'totalRatings':totalRatings
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] is int
          ? map['productPrice']
          : int.tryParse(map['productPrice']?.toString() ?? '0') ?? 0,
      quantity: map['quantity'] is int
          ? map['quantity']
          : int.tryParse(map['quantity']?.toString() ?? '0') ?? 0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      vendorId: map['vendorId'] ?? '',
      fullName: map['fullName'] ?? '',
      subCategory: map['subCategory'] ?? '',
      images: map['images'] == null
          ? <String>[]
          : List<String>.from(
              (map['images'] as List).map((e) => e.toString()),
            ),
      averageRating: map['averageRating'] as double,
      totalRatings: map['totalRatings'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}




// // TODO Implement this library.
// import 'dart:convert';

// class Product {
//   final String id;
//   final String productName;
//   final int productPrice;
//   final int quantity;
//   final String description;
//   final String category;
//   final String vendorId;
//   final String fullName;
//   final String subCategory;
//   final List<String> images;
//   // final bool popular; //popular ?? true;
//   // final bool recommend; //recommend ?? fals;

//   Product({
//     required this.id,
//     required this.productName,
//     required this.productPrice,
//     required this.quantity,
//     required this.description,
//     required this.category,
//     required this.vendorId,
//     required this.fullName,
//     required this.subCategory,
//     required this.images,
  
  
//     // required this.popular,
//     // required this.recommend, 
    
   
//   });

//    Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'productName': productName,
//       'productPrice': productPrice,
//       'quantity': quantity,
//       'description': description,
//      'category': category,
//      'vendorId':vendorId,
//      'fullName':fullName,
//       'subCategory': subCategory,
//       'images': images,
//     //  'popular': popular,
//     //  'recommend': recommend
//     };
//   }

//   factory Product.fromJson(Map<String, dynamic> map) {
//     return Product(
//       id: map['_id'] ?? '',
//       productName: map['productName'] ?? '',
//       productPrice: map['productPrice'] ?? '',
//       quantity: map['quantity'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//        vendorId: map['vendorId'] ?? '',
//         fullName: map['fullName'] ?? '',
//       subCategory: map['subCategory'] ?? '',
//       images:  List<String>.from((map['images'] as List<dynamic>)),

    
//     );
//   }

//     String toJson() => json.encode(toMap());

// }

import 'dart:convert';

class BannerModel {
  final String id;
  final String image;
  final String name;

  BannerModel({
    required this.id,
    required this.image,
    required this.name
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

   factory BannerModel.fromJson(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    image: map['image'] ?? '',
    );
  }
   String toJson() => json.encode(toMap());

}

class Favourite {
  final String productName;
  final int productPrice;
  final String productId;
  final int productQuantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final List<String> image;
   int quantity;

  Favourite({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.image,
    required this.quantity,
  });
}

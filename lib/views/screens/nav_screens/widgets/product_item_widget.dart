import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/Details/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailScreen(product: product);
        }));
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(22),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
              children:[ product.images.isNotEmpty
                  ? Image.network(
                    product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey[700],
                          ),
                        );
                      },
                    )

                  : Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 5,
                      child: Image.asset("assets/icons/love.png"),
                      height: 26,
                      width: 26,),

                    Positioned(
                      top: 3,
                     left: 3,
                      child: Image.asset("assets/icons/cart.png"),
                      height: 26,
                      width: 26,),
                    ]
              )

            ),
            const SizedBox(height: 8),
            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "\$${product.productPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:e_commerce_app/controllers/product_controller.dart';
// import 'package:e_commerce_app/models/product_model.dart';
// import 'package:e_commerce_app/views/Details/screen/product_detail_screen.dart';
// import 'package:flutter/material.dart';

// class ProductItemWidget extends StatefulWidget {
//   const ProductItemWidget({super.key, required Product product});

//   @override
//   State<ProductItemWidget> createState() => _ProductItemWidgetState();
// }

// class _ProductItemWidgetState extends State<ProductItemWidget> {
//   late Future<List<Product>> futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     loadProducts();
//   }

//   void loadProducts() {
//     futureProducts = ProductController().loadProducts();
//   }

//   // 🔹 Resolve image URL (same as ProductWidget)
//   String resolveImageUrl(String image) {
//     if (image.startsWith('http')) return image;
//     const baseUrl =
//         'https://api.your-backend.com'; // 🔹 Replace with your real base URL
//     return '$baseUrl/$image';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: futureProducts,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No Products'));
//         }

//         final products = snapshot.data!;

//         // Display as horizontal scrollable like ProductItemWidget
//         return SizedBox(
//           height: 250,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];

//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => ProductDetailScreen(product: product),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 170,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product image
//                       Container(
//                         height: 170,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(22),
//                         ),
//                         clipBehavior: Clip.hardEdge,
//                         child: Stack(
//                           children: [
//                             product.images.isNotEmpty
//                                 ? Image.network(
//                                     product.images[0],
//                                     width: double.infinity,
//                                     height: double.infinity,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder:
//                                         (context, child, loadingProgress) {
//                                           if (loadingProgress == null)
//                                             return child;
//                                           return const Center(
//                                             child: CircularProgressIndicator(),
//                                           );
//                                         },
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return const Center(
//                                         child: Icon(
//                                           Icons.broken_image,
//                                           size: 50,
//                                           color: Colors.grey,
//                                         ),
//                                       );
//                                     },
//                                   )
//                                 : const Center(
//                                     child: Icon(Icons.image, size: 50),
//                                   ),
//                             // Favorite icon
//                             Positioned(
//                               top: 15,
//                               right: 5,
//                               child: Image.asset(
//                                 "assets/icons/love.png",
//                                 height: 26,
//                                 width: 26,
//                               ),
//                             ),
//                             // Cart icon
//                             Positioned(
//                               top: 5,
//                               left: 5,
//                               child: Image.asset(
//                                 "assets/icons/cart.png",
//                                 height: 26,
//                                 width: 26,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         product.productName,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "\$${product.productPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

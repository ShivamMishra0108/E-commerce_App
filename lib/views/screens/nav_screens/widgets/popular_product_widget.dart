// import 'package:e_commerce_app/controllers/product_controller.dart';
// import 'package:e_commerce_app/models/product_model.dart';
// import 'package:e_commerce_app/views/screens/nav_screens/widgets/product_item_widget.dart';
// import 'package:e_commerce_app/views/screens/nav_screens/widgets/product_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class PopularProductWidget extends StatefulWidget {
//   const PopularProductWidget({super.key});

//   @override
//   State<PopularProductWidget> createState() => _PopularProductWidgetState();
// }

// class _PopularProductWidgetState extends State<PopularProductWidget> {

//   late Future<List<Product>>  futurePopularProducts;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     futurePopularProducts = ProductController().getPopularProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: futurePopularProducts,
//       builder: (context, snapshot) {
//         if(snapshot.connectionState== ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator(),);
//         }else if(snapshot.hasError){
//           return Center(child: Text("Error: ${snapshot.error}"),);
//         }else if(!snapshot.hasData || snapshot.data!.isEmpty){
//           return Center(child: Text("No Popular Products"),);
//         }else{
//           final products = snapshot.data;
//           return SizedBox(
//             height: 250,
//             child: ListView.builder(
//               itemCount: products!.length,
//                 scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemBuilder: (context, index){
//                 final product = products[index];
//                 print(product.images);

//                return ProductItemWidget(product: product);
//               }),
//           );
//         }
//       });
//   }

// }

import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/favourite_provider.dart';
import 'package:e_commerce_app/views/Details/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  _PopularProductWidgetState createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  late Future<List<Product>> futurePopularProducts;

  @override
  void initState() {
    super.initState();
    loadPopularProducts();
  }

  void loadPopularProducts() {
    futurePopularProducts = ProductController().loadProducts();
    // or getPopularProduct() if you want only popular ones
  }

  String resolveImageUrl(String image) {
    if (image.startsWith('http')) return image;
    const baseUrl = 'https://api.your-backend.com'; // replace with your backend
    return '$baseUrl/$image';
  }

  @override
  Widget build(BuildContext context) {
    final _favouriteProvider = ref.read(favouriteProvider.notifier);
    final favouriteItems = ref.watch(favouriteProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartItems = ref.watch(cartProvider);

    return FutureBuilder<List<Product>>(
      future: futurePopularProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Popular Products"));
        }

        final products = snapshot.data!;

        return SizedBox(
          height: 250, // height matches ProductItemWidget
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                width: 170,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              product.images.isNotEmpty
                                  ? Image.network(
                                      resolveImageUrl(product.images[0]),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(Icons.image, size: 50),
                                    ),

                              Positioned(
                                top: 6,
                                right: 6,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                    icon: favouriteItems.containsKey(product.id)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                          )
                                        : const Icon(Icons.favorite_border),
                                    onPressed: () {
                                      if (!favouriteItems.containsKey(
                                        product.id,
                                      )) {
                                        _favouriteProvider
                                            .addProductToFavourite(
                                              productId: product.id,
                                              productName: product.productName,
                                              productPrice:
                                                  product.productPrice,
                                              productQuantity: product.quantity,
                                              description: product.description,
                                              category: product.category,
                                              vendorId: product.vendorId,
                                              fullName: product.fullName,
                                              image: product.images,
                                              averageRating:
                                                  product.averageRating,
                                              quantity: 1,
                                            );
                                        showSnackBar(
                                          context,
                                          "${product.productName} added to favourites",
                                        );
                                      } else {
                                        _favouriteProvider.removeFavouriteItem(
                                          product.id,
                                        );
                                        showSnackBar(
                                          context,
                                          "removed from wishlist",
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                    icon: cartItems.containsKey(product.id)
                                        ? const Icon(
                                            Icons.shopping_bag,
                                            color: Colors.amber,
                                          )
                                        : const Icon(
                                            Icons.shopping_bag_outlined,
                                          ),
                                    onPressed: () {
                                      if (!cartItems.containsKey(product.id)) {
                                        _cartProvider.addProductToCart(
                                          productId: product.id,
                                          productName: product.productName,
                                          productPrice: product.productPrice,
                                          productQuantity: product.quantity,
                                          description: product.description,
                                          category: product.category,
                                          vendorId: product.vendorId,
                                          fullName: product.fullName,
                                          image: product.images,
                                          averageRating: product.averageRating,
                                          quantity: 1,
                                        );
                                        showSnackBar(
                                          context,
                                          "${product.productName} Added to Cart",
                                        );
                                      } else {
                                        _cartProvider.removeItem(product.id);
                                        showSnackBar(
                                          context,
                                          "removed from cart",
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              if (product.averageRating > 0)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text("${product.averageRating}"),
                                  ],
                                ),

                              const SizedBox(height: 4),

                              Text(
                                "₹${product.productPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

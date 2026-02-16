import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get favourites map from provider
    final favouritesMap = ref.watch(favouriteProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final _favouriteProvide = ref.read(favouriteProvider.notifier);
    final favourites = favouritesMap.values
        .toList(); // convert to list for ListView

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(118),
        child: Container(
          width: double.infinity,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/cartb.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 360,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/not.png", height: 25, width: 25),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 15,
                        width: 15,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            favourites.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 60,
                top: 51,
                child: Text(
                  "My Favourites",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 51,
                child: Image.asset(
                  "assets/icons/cart.png",
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: favourites.isEmpty
          ? Center(child: Text("No Favourite Products Found"))
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final favourite = favourites[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductDetailScreen(product: favourite),
                      //   ),
                      // );
                    },
                    title: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Product Image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              favourite.image[0],
                              height: 160,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          // Product Details
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favourite.productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(favourite.category),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    Text("${favourite.averageRating}"),
                                  ],
                                ),
                                Text(
                                  "\$${favourite.productPrice}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _cartProvider.addProductToCart(
                                      productId: favourite.productId,
                                      productName: favourite.productName,
                                      productPrice: favourite.productPrice,
                                      productQuantity: favourite.quantity,
                                      description: favourite.description,
                                      category: favourite.category,
                                      vendorId: favourite.vendorId,
                                      fullName: favourite.fullName,
                                      image: favourite.image,
                                      quantity: 1,
                                    );

                                    showSnackBar(
                                      context,
                                      "${favourite.productName} Added to Cart",
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Delete Button
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    _favouriteProvide.removeFavouriteItem(
                                      favourite.productId,
                                    );
                                  },
                                  icon: Icon(
                                    _favouriteProvide.getFavouriteItems
                                            .containsKey(favourite.productId)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    _favouriteProvide.removeFavouriteItem(
                                      favourite.productId,
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/icons/delete.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

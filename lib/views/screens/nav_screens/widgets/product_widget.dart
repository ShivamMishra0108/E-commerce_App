import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  late Future<List<Product>> futureproducts;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    futureproducts = ProductController().loadProducts();
  }

  void reload() => loadData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureproducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Products"));
        }

        final products = snapshot.data!;

        return GridView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Container(
              margin: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        product.images.isNotEmpty
                            ? Image.network(
                                product.images[0],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey[700],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.grey[700],
                                ),
                              ),

                        Positioned(
                          top: 10,
                          right: 8,
                          child: Image.asset(
                            "assets/icons/love.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 8,
                          child: Image.asset(
                            "assets/icons/cart.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

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

                  Text(
                    "\$${product.productPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

import 'dart:ffi';

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
    backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: const Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Product Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_outline),
                          onPressed: () {},
                        ),
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.shopping_bag_outlined),
                              onPressed: () {},
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        Text(
                          widget.product.category,
                          style: const TextStyle(color: Color(0xFF6B7280)),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                        Text(
                          widget.product.subCategory,
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                        Text(
                          widget.product.productName,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Product Details
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isWide = constraints.maxWidth > 768;

                        Widget productImage = widget.product.images.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: Colors.grey.shade200,
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  child: Center(
                                    child: Image.network(
                                      widget.product.images.first,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                            if (progress == null) return child;
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.broken_image,
                                              size: 100,
                                              color: Colors.grey,
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: isWide ? 320 : 320,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, size: 80),
                                ),
                              );

                        Widget productInfo(Product product) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // PRODUCT NAME
                                    Text(
                                      product.productName,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                
                                    const SizedBox(height: 8),
                                
                                    // PRICE
                                    Text(
                                      "\$${product.productPrice}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                
                                    const SizedBox(height: 16),
                                
                                  
                                   
                                    const SizedBox(height: 8),
                                
                                    // DESCRIPTION
                                    Text(
                                      product.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.6,
                                        color: Color(0xFF4B5563),
                                      ),
                                    ),
                                     Text(
                                      "Add to Cart",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.6,
                                        color: Color(0xFF4B5563),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        if (isWide) {
                          /// Desktop / Tablet layout
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(child: productImage),
                              const SizedBox(width: 32),
                              SizedBox(child: productInfo(widget.product)),
                            ],
                          );
                        } else {
                          /// Mobile layout
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              productImage,
                              const SizedBox(height: 24),
                              productInfo(widget.product),
                              const SizedBox(height: 100),

                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            _cartProvider.addProductToCart(
              productId: widget.product.id,
              productName: widget.product.productName,
              productPrice: widget.product.productPrice,
              productQuantity: widget.product.quantity,
              description: widget.product.description,
              category: widget.product.category,
              vendorId: widget.product.vendorId,
              fullName: widget.product.fullName,
              image: widget.product.images,
              quantity: 1,
            );

            showSnackBar(
              context,
              "${widget.product.productName} Added to Cart",
            );
          },
          child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

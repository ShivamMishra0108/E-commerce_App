

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
              child: Stack(// to make rounded corners work
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

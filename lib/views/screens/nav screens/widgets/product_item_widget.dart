import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItemWidget extends StatelessWidget {
final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Image.network(product.images[0],height: 10, width: 170,fit: BoxFit.cover)
        ],
      ),
          )
        ],
      ),
    );
  }
}
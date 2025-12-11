import 'package:flutter/material.dart';

class InnerBannerWidgert extends StatelessWidget {
  final String image;

  const InnerBannerWidgert({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.width,
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(50),
          child: Image.network(image),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubcategoryTileWidget extends StatelessWidget {
  final String image;
  final String title;

  const SubcategoryTileWidget({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
            color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(50),
              child: Image.network(image),
            ),
          ),
           const SizedBox(height: 8,),
           Text(title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),)
        ],
      ),
    );
    
  }
}

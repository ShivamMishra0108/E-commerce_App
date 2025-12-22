import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
           style:  GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
          ),),
           Text(subtitle,
           style:  GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue
          ),
        
          )
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/views/screens/nav%20screens/widgets/banner_widget.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/category_widget.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/header_widget.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/popular_product_widget.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/reuseable_textWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          HeaderWidget(),
           BannerWidget(),
           CategoryWidget(),
           TextWidget(title:" Popular Products", subtitle: "view all"),
           PopularProductWidget()
           ]),
      ),
    );
  }
}

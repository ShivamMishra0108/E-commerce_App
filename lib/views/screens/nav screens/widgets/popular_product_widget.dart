import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});

  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {

  late Future<List<Product>>  futurePopularProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularProducts = ProductController().loadAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePopularProducts, 
      builder: (context, snapshot) {
        if(snapshot.connectionState== ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text("Error: ${snapshot.error}"),);
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text("No Popular Products"),);
        }else{
          final products = snapshot.data;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: products!.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                final product = products[index];
                return ProductItemWidget(product: product,);
              }),
          );
        }
      });
  }
}
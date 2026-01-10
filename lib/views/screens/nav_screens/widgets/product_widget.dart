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
    // TODO: implement initState
    loadData();
  }

  void loadData() {
    setState(() {
      futureproducts = ProductController().loadProducts();
    });
  }

  void reload() => loadData();

  @override
  Widget build(BuildContext context) {
    return 
        FutureBuilder(
          future: futureproducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No Products"));
            }

            final products = snapshot.data!;

            return GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                   decoration: BoxDecoration(
                      border: Border.all(
                        color:  Colors.grey,
                        width:  1,
                      ),
                      borderRadius: BorderRadius.circular(12)
                    ),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                           product.images.isNotEmpty
                                ? Image.network(
                                    product.images[0],
                                    height: 70,
                                    width: 70,
                                  )
                                : Icon(Icons.image_not_supported, size: 60),
                        
                            SizedBox(height: 8),
                            
                            Text(
                              product.productName,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                
                            SizedBox(height: 12,),
                
                            Text(
                             "/${ product.subCategory}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14
                              ),
                            ),
                
                            Text(
                              "/${product.category}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      
    
  }
}

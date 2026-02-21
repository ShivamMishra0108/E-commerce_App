import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends StateNotifier<List<Product>>{
  ProductProvider(): super([]);

  void SetProducts(List<Product> products){
    state = products;
  }
}

final productProvider = StateNotifierProvider<ProductProvider, List<Product>>((ref){
  return ProductProvider();
});



                               
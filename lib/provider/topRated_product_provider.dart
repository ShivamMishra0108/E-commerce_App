import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopratedProductProvider extends StateNotifier<List<Product>>{
  TopratedProductProvider(): super([]);

  void SetProducts(List<Product> products){
    state = products;
  }
}

final topRatedProductProvider = StateNotifierProvider<TopratedProductProvider, List<Product>>((ref){
  return TopratedProductProvider();
});



                               
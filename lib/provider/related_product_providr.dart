import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelatedProductProvider extends StateNotifier<List<Product>>{
  RelatedProductProvider(): super([]);

  void SetProducts(List<Product> products){
    state = products;
  }
}

final relatedProductProvider = StateNotifierProvider<RelatedProductProvider, List<Product>>((ref){
  return RelatedProductProvider();
});



                               
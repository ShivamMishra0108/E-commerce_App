import 'package:e_commerce_app/models/category_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends StateNotifier<List<Category>>{
  CategoryProvider(): super([]);

  void SetCategory(List<Category> category){
    state = category;
  }
}

final categoryProvider = StateNotifierProvider<CategoryProvider, List<Category>>((ref){
  return CategoryProvider();
});
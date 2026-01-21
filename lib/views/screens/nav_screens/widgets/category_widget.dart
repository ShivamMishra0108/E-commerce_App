import 'package:e_commerce_app/controllers/category_controller.dart';
import 'package:e_commerce_app/provider/category_provider.dart';
import 'package:e_commerce_app/views/Details/screen/innerr_category_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/widgets/reuseable_textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchCategory();
   
  }

  Future<void> fetchCategory()async{
    final CategoryController _categoryController = CategoryController();
    try {
      final categories = await _categoryController.loadCategories();

      ref.read(categoryProvider.notifier).SetCategory(categories);

    } catch (e) {
      
    }
  }


  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title: "Categories", subtitle: "View All"),
       GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final Category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InnerCategoryScreen(category: Category,);
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.network(Category.image, height: 47, width: 47),
                        Text(Category.name),
                      ],
                    ),
                  );
                },
              )
      ],
    );
  }
}

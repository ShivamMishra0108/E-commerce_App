import 'package:e_commerce_app/controllers/category_controller.dart';
import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/views/screens/nav%20screens/widgets/reuseable_textWidget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title: "Categories", subtitle: "View All"),
        FutureBuilder(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No categories"));
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final Category = categories[index];
                  return Column(
                    children: [
                      Image.network(Category.image, height: 47, width: 47),
                      Text(Category.name),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}

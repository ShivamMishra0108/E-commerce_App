import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/controllers/subCategory_controller.dart';
import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/subCategory_model.dart';
import 'package:e_commerce_app/views/Details/widgets/inner_banner_widgert.dart';
import 'package:e_commerce_app/views/Details/widgets/inner_header_widget.dart';
import 'package:e_commerce_app/views/Details/widgets/subCategory_tile_widget.dart';
import 'package:e_commerce_app/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:e_commerce_app/views/screens/nav_screens/widgets/reuseable_textWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContent extends StatefulWidget {
  final Category category;

  const InnerCategoryContent({super.key, required this.category});

  @override
  State<InnerCategoryContent> createState() => _InnerCategoryContentState();
}

class _InnerCategoryContentState extends State<InnerCategoryContent> {
  late Future<List<Subcategory>> _subcategories;
  List<Product> _products = [];
  final SubcategoryController _subcategoryController = SubcategoryController();
  final ProductController _productController = ProductController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subcategoryController.getSubCategoryByCategory(
      widget.category.name,
    );

    _loadProducts(widget.category.name);
  }

  Future<void> _loadProducts(String categoryName) async {
    final products = await _productController.getProductByCategory(
      categoryName,
    );
    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: InnerHeaderWidget(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidgert(image: widget.category.banner),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Shop by Categories",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            FutureBuilder(
              future: _subcategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No Subcategories"));
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subcategories.length / 7).ceil(),
                        (setIndex) {
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          return Padding(
                            padding: EdgeInsetsGeometry.all(1.8),
                            child: Row(
                              children: subcategories
                                  .sublist(
                                    start,
                                    end > subcategories.length
                                        ? subcategories.length
                                        : end,
                                  )
                                  .map(
                                    (subcategories) => SubcategoryTileWidget(
                                      image: subcategories.image,
                                      title: subcategories.subCategoryName,
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            const TextWidget(title: 'Popular Products', subtitle: 'view all'),

            SizedBox(
              height: 250,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];

                  return SubcategoryTileWidget(
                    image: product.images[0],
                    title: product.productName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

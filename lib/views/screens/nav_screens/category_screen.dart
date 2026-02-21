import 'package:e_commerce_app/controllers/category_controller.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/controllers/subCategory_controller.dart';
import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/subCategory_model.dart';
import 'package:e_commerce_app/views/Details/widgets/subCategory_tile_widget.dart';
import 'package:e_commerce_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category? _selectedcategory;

  late Future<List<Category>> futureCategories;
  List<Subcategory> _subcategories = [];
  List<Product> _products = [];

  final SubcategoryController _subCategoryController = SubcategoryController();
  final ProductController _productController = ProductController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();

    futureCategories.then((categories) {
      for (var category in categories) {
        if (category.name == "Footwear") {
          setState(() {
            _selectedcategory = category;
          });
          _loadSubCategories(category.name);
          _loadProducts(category.name);
        }
      }
    });
  }

  Future<void> _loadSubCategories(String categoryName) async {
    final subcategories = await _subCategoryController.getSubCategoryByCategory(
      categoryName,
    );
    setState(() {
      _subcategories = subcategories;
    });
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
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80),
      //   child: SafeArea(child: HeaderWidget()),
      // ),
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade200,
                    child: FutureBuilder(
                      future: futureCategories,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text("No categories"));
                        } else {
                          final categories = snapshot.data!;
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    _selectedcategory = category;
                                  });
                                  _loadSubCategories(category.name);
                                  _loadProducts(category.name);
                                },
                                title: Text(
                                  category.name,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedcategory == category
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                //RIGHT SIDE:
                Expanded(
                  flex: 5,
                  child: _selectedcategory != null
                      ? SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _selectedcategory!.name,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        _selectedcategory!.banner,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Sub Categories",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 140, // height of the horizontal grid
                                child: GridView.builder(
                                  scrollDirection: Axis
                                      .horizontal, // make it scroll horizontally
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, // 1 row
                                        mainAxisSpacing: 8,
                                        childAspectRatio:
                                            1.2, // adjust for width/height of tiles
                                      ),
                                  itemCount: _subcategories.length,
                                  itemBuilder: (context, index) {
                                    final subcategory = _subcategories[index];
                                    return SubcategoryTileWidget(
                                      image: subcategory.image,
                                      title: subcategory.subCategoryName,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Products",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 140,
                                child: GridView.builder(
                                  scrollDirection: Axis
                                      .horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
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
                      )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

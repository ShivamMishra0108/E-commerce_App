import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/views/Details/widgets/inner_category_content.dart';
import 'package:e_commerce_app/views/screens/nav_screens/Store_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/account_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/cart_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/category_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {

    int _pageIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      InnerCategoryContent(category: widget.category),
      FavoriteScreen(),
      CategoryScreen(),
      StoreScreen(),
      CartScreen(),
      AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: pages[_pageIndex],

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", width: 25),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/love.png", width: 25),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.category,),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/mart.png", width: 25),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/cart.png", width: 25),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png", width: 25),
            label: "Account",
          ),
        ],
      ),
      
    );
  }
}

<<<<<<< HEAD
# e_commerce_app

Features

 User Authentication (Login / Register)
 Home Screen with Product Categories
 Product Search & Filters
 Add to Cart / Remove from Cart
 Add / remove to  Wishlist
 Checkout Screen 
 Product Detail Screen
 Order History
 User Profile Management
 API Integration
 
Tech Stack:

Flutter
Dart
State Management (Provider - Riverpod)
REST API / node js Mongo db
Local Storage (SharedPreferences)
Cloudinary
Custom rating Bar


Project Structure: 
-lib-
|   |   global_variable.dart
|   |   main.dart
|   |
|   +---controllers
|   |       auth_controller.dart
|   |       banner_controller.dart
|   |       category_controller.dart
|   |       orderController.dart
|   |       product_controller.dart
|   |       product_review_controller.dart
|   |       subCategory_controller.dart
|   |
|   +---models
|   |       banner_model.dart
|   |       cart_model.dart
|   |       category_models.dart
|   |       favourite.dart
|   |       order.dart
|   |       product_model.dart
|   |       product_review.dart
|   |       subCategory_model.dart
|   |       user.dart
|   |
|   +---provider
|   |       banner_provider.dart
|   |       cart_provider.dart
|   |       category_provider.dart
|   |       favourite_provider.dart
|   |       order_provider.dart
|   |       product_provider.dart
|   |       user_provider.dart
|   |
|   +---services
|   |       manage_http_responses.dart
|   |
|   \---views
|       +---Details
|       |   +---screen
|       |   |       checkout_screen.dart
|       |   |       innerr_category_screen.dart
|       |   |       order_detail_screen.dart
|       |   |       product_detail_screen.dart
|       |   |       shipping_address_screen.dart
|       |   |
|       |   \---widgets
|       |           inner_banner_widgert.dart
|       |           inner_category_content.dart
|       |           inner_header_widget.dart
|       |           order_screen.dart
|       |           shipping_address.dart
|       |           subCategory_tile_widget.dart
|       |
|       \---screens
|           |   main_screen.dart
|           |   
|           +---auth_screens
|           |       login_screen.dart
|           |       register_screen.dart
|           |
|           \---nav_screens
|               |   account_screen.dart
|               |   cart_screen.dart
|               |   category_screen.dart
|               |   favorite_screen.dart
|               |   home_screen.dart
|               |   Store_screen.dart
|               |
|               \---widgets
|                       banner_widget.dart
|                       category_widget.dart
|                       header_widget.dart
|                       popular_product_widget.dart
|                       product_item_widget.dart
|                       product_widget.dart
|                       reuseable_textWidget.dart


 Author:

Shivam Mishra
GitHub: https://github.com/ShivamMishra0108
LinkedIn: https://www.linkedin.com/in/shivam-mishra-021675382/






// A notifier class to manage the cart state , extending stateNotifier
// with an itntial stste of empty map

import 'dart:convert';

import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a stateNotifierProvider to expose an instance of cartNotifier 
// making it accessibel within our app

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref){
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({}){
    _loadCartItems();
  }


  
  // A Private Method that load the current list of items from shared preferences
  Future<void> _loadCartItems() async{

    // Retreiving the shared preferences instance to store data
    final prefs = await SharedPreferences.getInstance();

    // fetch the json String of the cart items retrieved
    final cartString = await prefs.getString("cart_items");

    // Check if the json String is not null
    if(cartString != null){
      
      // Decode the json String into dynamic MAP
      final Map<String,dynamic> cartMap = jsonDecode(cartString);

      // Convert the dynamic map into the MAP of cart items using "fromJson" Factory Method:
      final carts = cartMap.map((key,value) => MapEntry(key, Cart.fromJson(value)));

      // Updating the state with the loaded cart items:
      state = carts;
    }
  }


  
  // A Private Method that save the current list of items to shared preferences
  Future<void> _saveCartItems() async{

    // Retreiving the shared preferences instance to store data
    final prefs = await SharedPreferences.getInstance();

    // encoding the current state(map of items) into json string
    final cartString = jsonEncode(state);

    // Saving the json string to shared prefernces with the key favourites:
    await prefs.setString("cart_items", cartString);

  }

  // Mehtod to add Product to the Cart:
  void addProductToCart({
    required String productId,
    required String productName,
    required int productPrice,
    required int productQuantity,
    required String description,
    required String category,
    required String vendorId,
    required String fullName,
    required List<String> image,
    required double averageRating,
    required int quantity,
  }) {
    // checking if the product is already in the cart
    if (state.containsKey(productId)) {
      // Add the quantity and may be other details:
      state = {
        ...state,
        productId: Cart(
          productId: state[productId]!.productId,
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          productQuantity: state[productId]!.productQuantity,
          description: state[productId]!.description,
          category: state[productId]!.category,
          vendorId: state[productId]!.vendorId,
          fullName: state[productId]!.fullName,
          image: state[productId]!.image,
          averageRating: state[productId]!.averageRating,
          quantity: state[productId]!.quantity + 1,
        ),
      };
      _saveCartItems();
    } else {
      // If Product is not in the Cart , Add it with the provided details:
      state = {
        ...state,
        productId: Cart(
          productId: productId,
          productName: productName,
          productPrice: productPrice,
          productQuantity: productQuantity,
          description: description,
          category: category,
          vendorId: vendorId,
          fullName: fullName,
          image: image,
          averageRating: averageRating,
          quantity: quantity,
        ),
      };
      _saveCartItems();
    }
  }

  // Method to increment the quantity of a product in cart:
  void incrementQuantity(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity++;

    // NOtify listeners that the state has changed:
      state = {...state};
      _saveCartItems();
    }
  }

  // Method to decrement the quantiy of the product in cart
  void decrementQuantity(String productId){
    if(state.containsKey(productId)){
      if(state[productId]!.quantity>0){
        state[productId]!.quantity--;
    
      }
    // NOtify listeners that the state has changed:
    state = {...state};
    _saveCartItems();
    }
  }

  // MEthod to remove the product from the cart
  void removeItem(String productId){
    state.remove(productId);

    // NOtify listeners that the state has changed:
    state = {...state};
    _saveCartItems();
  }

  // Method to calculate total amount of items we have in cart
  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId, cartItem){
      totalAmount  += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }

  Map<String, Cart> get getCartItems => state;
 }


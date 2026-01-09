// A notifier class to manage the cart state , extending stateNotifier
// with an itntial stste of empty map

import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a stateNotifierProvider to expose an instance of cartNotifier 
// making it accessibel within our app

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref){
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

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
          quantity: state[productId]!.quantity + 1,
        ),
      };
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
          quantity: quantity,
        ),
      };
    }
  }

  // Method to increment the quantity of a product in cart:
  void incrementQuantity(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity++;

    // NOtify listeners that the state has changed:
      state = {...state};
    }
  }

  // Method to decrement the quantiy of the product in cart
  void decrementQuantity(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity--;

    // NOtify listeners that the state has changed:
    state = {...state};
    }
  }

  // MEthod to remove the product from the cart
  void removeItem(String productId){
    state.remove(productId);

    // NOtify listeners that the state has changed:
    state = {...state};
  }

  // Method to calculate total amount of items we have in cart
  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId, cartItem){
      totalAmount  += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}


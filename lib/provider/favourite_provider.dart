// // A notifier class to manage the wishlist state , extending stateNotifier
// // with an itntial state of empty map

import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/models/favourite.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Define a stateNotifierProvider to expose an instance of favouriteNotifier
// // making it accessibel within our app

// final favouriteProvider =
//     StateNotifierProvider<FavouriteNotifier, Map<String, Favourite>>((ref) {
//       return FavouriteNotifier();
//     });

// class FavouriteNotifier extends StateNotifier<Map<String, Favourite>> {
//   FavouriteNotifier() : super({});

//   // Mehtod to add Product to the wishlist:

//   void addProductToFavourite({
//     required String productId,
//     required String productName,
//     required int productPrice,
//     required int productQuantity,
//     required String description,
//     required String category,
//     required String vendorId,
//     required String fullName,
//     required List<String> image,
//     required double averageRating,
//     required int quantity,
//   }) {
//     state[productId] = Favourite(
//       productId: productId,
//       productName: productName,
//       productPrice: productPrice,
//       productQuantity: productQuantity,
//       description: description,
//       category: category,
//       vendorId: vendorId,
//       fullName: fullName,
//       image: image,
//       averageRating: averageRating,
//       quantity: quantity,
//     );

   
//     // notify listeners that the state has changed:
//     state = {...state};
   

//   }



//   // MEthod to remove the product from the wishlist
//   void removeFavouriteItem(String productId){
//     state.remove(productId);

//     // NOtify listeners that the state has changed:
//     state = {...state};
//   }


//     Map<String, Favourite> get getFavouriteItems => state;


// }


final favouriteProvider =
    StateNotifierProvider<FavouriteNotifier, Map<String, Favourite>>(
  (ref) => FavouriteNotifier(),
);

class FavouriteNotifier extends StateNotifier<Map<String, Favourite>> {
  FavouriteNotifier() : super({});

  void addProductToFavourite({
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
    state = {
      ...state,
      productId: Favourite(
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
  }

  void removeFavouriteItem(String productId) {
    final updatedState = {...state};
    updatedState.remove(productId);
    state = updatedState;
  }

  Map<String, Favourite> get getFavouriteItems => state;
}

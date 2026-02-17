import 'dart:convert';

import 'package:e_commerce_app/models/favourite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A notifier class to manage the wishlist state , extending stateNotifier
// with an itntial state of empty
final favouriteProvider =
    StateNotifierProvider<FavouriteNotifier, Map<String, Favourite>>(
      (ref) => FavouriteNotifier(),
    );

class FavouriteNotifier extends StateNotifier<Map<String, Favourite>> {
  FavouriteNotifier() : super({}){
    _loadPrefernces();
  }


  // A Private Method that load the current list of items from shared preferences
  Future<void> _loadPrefernces() async{

    // Retreiving the shared preferences instance to store data
    final prefs = await SharedPreferences.getInstance();

    // fetch the json String of the facourite items retrieved
    final favouriteString = await prefs.getString("favourites");

    // Check if the json String is not null
    if(favouriteString != null){
      
      // Decode the json String into dynamic MAP
      final Map<String,dynamic> favouriteMap = jsonDecode(favouriteString);

      // Consvert the dynamic map into the MAP of favourtie objects using "fromJson" Factory Method:
      final favourites = favouriteMap.map((key,value) => MapEntry(key, Favourite.fromJson(value)));

      // Updating the state with the loaded favourite objects:
      state = favourites;
    }
  }


  // A Private Method that save the current list of items to shared preferences
  Future<void> _savePreferences() async{

    // Retreiving the shared preferences instance to store data
    final prefs = await SharedPreferences.getInstance();

    // encoding the cue=rrent state(map of items) into json string
    final favouriteString = jsonEncode(state);

    // Saving the json string to shared prefernces with the key favourites:
    await prefs.setString("favourites", favouriteString);

  }

  // Mehtod to add Product to the wishlist:
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
    _savePreferences();
  }

  // MEthod to remove the product from the wishlist
  void removeFavouriteItem(String productId) {
    final updatedState = {...state};
    updatedState.remove(productId);
    state = updatedState;
    _savePreferences();
  }

  Map<String, Favourite> get getFavouriteItems => state;
}

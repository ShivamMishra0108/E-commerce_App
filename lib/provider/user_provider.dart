// import 'package:e_commerce_app/models/user.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart' show StateNotifier;


// //Contctruvtor Initializing default user object:
 
// class UserProvider extends StateNotifier<User?> {
//   UserProvider()
//     : super(
//         User(
//           id: '',
//           fullName: '',
//           email: '',
//           state: '',
//           city: '',
//           locality: '',
//           password: '',
//           token: '',
//         ),
//       );

//     // Getter method to extract any object:

//     User? get user => state;

//     // Setter to set user state from jason:

//     void setUser(String userJson){
//       state = User.fromJson(userJson);
//     }

   
// }
//  //make the data accessible within the application:

//     final userProvider = StateNotifierProvider<UserProvider, User?> ((ref) => UserProvider());

  import 'dart:convert';
import 'package:e_commerce_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// StateNotifier to manage user state
class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null); // Start with null user

  // Getter
  User? get user => state;

  // Setter from JSON string
  // void setUser(String userJson) {
  //   state = User.fromJson(jsonDecode(userJson));
  // }
  void setUser(String userJson){
      state = User.fromJson(userJson);
    }
  
  // Clear user
  void signOut() {
    state = null;
  }
}

// Provider definition
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());

    


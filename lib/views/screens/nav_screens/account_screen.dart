import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/Details/widgets/order_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  final AuthController _authController = AuthController(); 


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return OrderScreen();
            }));
          }, child: Text("My Orders")),
          ElevatedButton(onPressed: ()async{
            await _authController.signOutUser(context: context);
          }, child: Text("Signout")),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String state;
  late String city;
  late String locality;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Delivery Address"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),

                Text(
                  "Enter Where Your Order will beplaced",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 31, 12, 79),
                  ),
                ),

                SizedBox(height: 30),

                TextFormField(
                  onChanged: (value) {
                    state = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter State";
                    }
                  },
                  decoration: InputDecoration(hint: Text("Enter State")),
                ),

                SizedBox(height: 10),

                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter city";
                    }
                  },
                  decoration: InputDecoration(hint: Text("Enter City")),
                ),
                SizedBox(height: 10),

                TextFormField(
                  onChanged: (value) {
                    locality = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter locality";
                    }
                  },
                  decoration: InputDecoration(labelText: "Enter Locality"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await _authController.updateUserLocation(
                context: context,
                id: 'id',
                state: state,
                city: city,
                locality: locality,
              );
            } else {
              print("Not valid");
            }
          },

          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

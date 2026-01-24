import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/global_variable.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);

    _stateController = TextEditingController(text: user?.state ?? " ");
    _cityController = TextEditingController(text: user?.city ?? " ");
    _localityController = TextEditingController(text: user?.locality ?? " ");
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updated = ref.read(userProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Delivery Address",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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
                  "Enter Where Your Order will be placed",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 31, 12, 79),
                  ),
                ),

                SizedBox(height: 30),

                TextFormField(
                  
                  controller: _stateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter State";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                  labelText: "State",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter city";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _localityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter locality";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                  labelText: "Locality / Street",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
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
              await _authController
                  .updateUserLocation(
                    context: context,
                    id: user!.id,
                    state: _stateController.text,
                    city: _cityController.text,
                    locality: _localityController.text,
                  )
                  .whenComplete(() {
                    updated.recreateUserState(
                      state: _stateController.text,
                      city: _cityController.text,
                      locality: _localityController.text,
                    );

                    showSnackBar(context, "Address Uploaded");

                    Navigator.pop(context);
                  });
            } else {
              print("Not valid");
            }
          },

          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(color: const Color.fromARGB(255, 16, 188, 100)),
            child: Center(
              child: Text(
                "Save Address",
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

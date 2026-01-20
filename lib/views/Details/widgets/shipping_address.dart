import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _localityController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = {
        'state': _stateController.text,
        'city': _cityController.text,
        'locality': _localityController.text,
      };
      print("Saved Address: $address");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Address Saved Successfully!")),
      );

      Navigator.pop(context, address);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Where should we deliver your order?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: "State",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your state' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your city' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _localityController,
                decoration: const InputDecoration(
                  labelText: "Locality / Street",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter locality' : null,
              ),
              const SizedBox(height: 15),

            
                SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 16, 188, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

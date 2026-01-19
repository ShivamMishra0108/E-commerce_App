import 'package:e_commerce_app/controllers/orderController.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
<<<<<<< HEAD
import 'package:e_commerce_app/views/Details/screen/shipping_address_screen.dart';
=======
import 'package:e_commerce_app/views/Details/widgets/shipping_address.dart';
>>>>>>> 05668c38dc49281dff192573d4c93d745e2e68c9
import 'package:flutter/cupertino.dart' as Icons;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPayment = "";
  final OrderController _orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    final cartAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    final user = ref.watch(userProvider);
<<<<<<< HEAD
=======

>>>>>>> 05668c38dc49281dff192573d4c93d745e2e68c9
    final double discount = cartAmount / 10;
    final double tax = (cartAmount / 100) * 5;
    final double shippingFee = 30;
    final double total = (cartAmount + tax + shippingFee) - discount;
    String totalString = total.toStringAsFixed(2);
    double totalRounded = double.parse(totalString);
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.CupertinoIcons.location),
                    SizedBox(width: 10),
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
<<<<<<< HEAD
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ShippingAddressScreen();
                        }));
=======
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShippingAddressScreen();
                            },
                          ),
                        );
>>>>>>> 05668c38dc49281dff192573d4c93d745e2e68c9
                      },
                      child: SizedBox(
                        width: 300,
                        height: 96,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 300,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 70,
                              top: 17,
                              child: SizedBox(
                                width: 215,
                                height: 41,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -1,
                                      left: -1,
                                      child: SizedBox(
                                        width: 219,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 114,
                                                child: user!.fullName.isNotEmpty? Text(
                                                  user.fullName,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),
                                                ):
                                                const Text(
                                                  'Your Name',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),
                                                )
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 114,
                                                child: user.locality.isNotEmpty? Text(
                                                  user.locality,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                   
                                                  ),
                                                ):
                                                const Text(
                                                  'Add Adress',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                   
                                                  ),
                                                )
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: user.city.isNotEmpty? Text(
                                                  user.city,
                                                 style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.3,
                                                ),
                                                ):
                                                 Text(
                                                'United state',
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.3,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: user.state.isNotEmpty? Text(
                                                  user.state,
                                                  style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  
                                                ),
                                                ):
                                                 Text(
                                                'Enter city',
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 16,
                              child: SizedBox.square(
                                dimension: 42,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 43,
                                        height: 43,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFBF7F5),
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.hardEdge,
                                          children: [
                                            Positioned(
                                              left: 11,
                                              top: 11,
                                              child: Image.network(
                                                height: 26,
                                                width: 26,
                                                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 255,
                              top: 25,
                              child: Image.network(
                                width: 20,
                                height: 20,
                                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    Container(
                      height: 88,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Icon(Icons.CupertinoIcons.plus),
                    ),
                  ],
                ),

                SizedBox(height: 35),

                Row(
                  children: [
                    Icon(Icons.CupertinoIcons.cube_box),
                    SizedBox(width: 10),
                    Text(
                      "Your Items",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                ListView.builder(
                  itemCount: cartData.length,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    final cartItem = cartData.values.toList()[index];
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 95,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 78,
                              height: 78,
                              child: Image.network(cartItem.image[0]),
                            ),
                            SizedBox(width: 10),

                            Icons.Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icons.Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 78,
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          cartItem.productName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "₹${cartItem.productPrice}"
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.pink,
                                          ),
                                        ),
                                        Text(
                                          cartItem.category,
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 35),

                Row(
                  children: [
                    Icon(Icons.CupertinoIcons.ticket),
                    SizedBox(width: 10),
                    Text(
                      "Voucher and Coupon",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                SizedBox(
                  width: 342,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 342,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: const Color(0xFFEFF0F2)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icons.Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 140,
                                  height: 35,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: "Enter Code",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),
                                Container(
                                  height: 35,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      65,
                                      194,
                                      166,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icons.Center(
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 305,
                        top: 25,
                        child: Image.network(
                          width: 20,
                          height: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                Row(
                  children: [
                    Icon(Icons.CupertinoIcons.creditcard),
                    SizedBox(width: 10),
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                Container(
                  width: 335,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEFF0F2)),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                    title: const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: Image.asset(
                      "assets/icons/password.png",
                      height: 25,
                      width: 25,
                    ),
                    children: [
                      CheckboxListTile(
                        title: const Text("UPI"),
                        value: selectedPayment == "upi",
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = "upi";
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Card"),
                        value: selectedPayment == "Card",
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = "Card";
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Cash on Delivery"),
                        value: selectedPayment == "COD",
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = "COD";
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                Container(
                  height: 5,
                  width: 350,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SubTotal       :"),
                        Text(
                          "₹${cartAmount.toString()}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping fee :"),
                        Text(
                          "30",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax                :"),
                        Text(
                          "${tax.toString()}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount       :"),
                        Text(
                          "- ${discount.toString()}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount   :",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "₹${totalRounded.toString()}",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
<<<<<<< HEAD
        child: 
         user.state.isEmpty?
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ShippingAddressScreen();
            }));
          }, child: Text("Select your Delivery Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,

          ),
          )):
           InkWell(
          onTap: () async {
            if (selectedPayment == "COD") {
              await Future.forEach(_cartProvider.getCartItems.entries, (entry) {
                var item = entry.value;
                _orderController.uploadOrder(
                  id: user.id,
                  fullName: user.fullName,
                  email: user.email,
                  state: user.state,
                  city: user.city,
                  locality: user.locality,
                  productName: item.productName,
                  productPrice: item.productPrice,
                  quantity: item.quantity,
                  category: item.category,
                  image: item.image[0],
                  buyerId: user.id,
                  vendorId: item.vendorId,
                  processing: true,
                  delivered: false,
                  context: context,
                );
              });
            }
          },
          child:
           Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              color: const Icons.Color.fromARGB(255, 43, 234, 174),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icons.Center(
              child: Text(
                selectedPayment == "COD" ? "Confirm Order" : "Pay Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
                     ),
        ),
=======
        child: ref.read(userProvider)!.state == ""
            ? TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ShippingAddressScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Please Enter Shipping Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : InkWell(
                onTap: () async {
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User not logged in")),
                    );
                    return;
                  }
                  if (selectedPayment == "COD") {
                    await Future.forEach(_cartProvider.getCartItems.entries, (
                      entry,
                    ) {
                      var item = entry.value;
                      _orderController.uploadOrder(
                        id: ' ',
                        fullName: user.fullName,
                        email: user.email,
                        state: 'MP',
                        city: 'Jabalpur',
                        locality: 'Chungi',
                        productName: item.productName,
                        productPrice: item.productPrice,
                        quantity: item.quantity,
                        category: item.category,
                        image: item.image[0],
                        buyerId: user.id,
                        vendorId: item.vendorId,
                        processing: true,
                        delivered: false,
                        context: context,
                      );
                    });
                  }
                },
                child: Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Icons.Color.fromARGB(255, 43, 234, 174),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icons.Center(
                    child: Text(
                      selectedPayment == "COD" ? "Confirm Order" : "Pay Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
>>>>>>> 05668c38dc49281dff192573d4c93d745e2e68c9
      ),
    );
  }
}


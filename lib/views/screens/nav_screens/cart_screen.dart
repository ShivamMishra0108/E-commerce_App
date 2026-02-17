import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/views/Details/screen/checkout_screen.dart';
import 'package:e_commerce_app/views/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.lightBlue.withOpacity(0.6),
                Colors.white.withOpacity(0.6),
                Colors.lightBlue.withOpacity(0.6),
              ],
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                left: 360,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/not.png", height: 25, width: 25),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 15,
                        width: 15,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            cartData.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 160,
                top: 51,
                child: Container(
                  height: 45,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter text",

                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            "assets/icons/search.png",
                            height: 20,
                            width: 20,
                          ),
                        ),

                        border: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 51,
                child: Text(
                  "My Cart",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 51,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/cart.png", height: 25, width: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: cartData.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      "assets/images/emptyCart.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                    },

                    child: Text("Shop Now"),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 20,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 68,
                          top: 15,
                          child: Text("You have ${cartData.length} Items"),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartData.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartData.values.toList()[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(cartItem.image[0]),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.productName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      cartItem.category,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    Text(
                                      cartItem.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    Text(
                                      "₹${cartItem.productPrice}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        letterSpacing: 0.05,
                                        color: Colors.green,
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,

                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _cartProvider.removeItem(
                                              cartItem.productId,
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                        ),

                                        SizedBox(width: 10),

                                        Container(
                                          height: 40,
                                          width: 117,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (cartItem.quantity == 1) {
                                                    _cartProvider.removeItem(
                                                      cartItem.productId,
                                                    );
                                                  }
                                                  _cartProvider
                                                      .decrementQuantity(
                                                        cartItem.productId,
                                                      );
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.minus,
                                                ),
                                                color: Colors.white,
                                              ),
                                              Text(
                                                cartItem.quantity.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),

                                              IconButton(
                                                onPressed: () {
                                                  _cartProvider
                                                      .incrementQuantity(
                                                        cartItem.productId,
                                                      );
                                                },
                                                icon: Icon(CupertinoIcons.plus),
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15),

                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.yellow.shade500,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Buy Now",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Sub Total: ₹${cartAmount.toString()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            InkWell(
              onTap: () {
                if (cartAmount != 0.0) {
                  Navigator.push(
                    context,
                    (MaterialPageRoute(
                      builder: (context) {
                        return CheckoutScreen();
                      },
                    )),
                  );
                }
              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: cartAmount == 0.0
                      ? Colors.grey
                      : Colors.yellow.shade600,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Place Order",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//₹${cartData.fold(0, (sum, item) => sum + item.productPrice * item.quantity
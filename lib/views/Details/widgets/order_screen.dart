import 'package:e_commerce_app/controllers/orderController.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/provider/order_provider.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final user = ref.read(userProvider);

    print("FLUTTER buyerId: ${user?.id}");

    if (user != null) {
      OrderController orderController = OrderController();

      try {
        final orders = await orderController.loadOrders(buyerId: user.id);
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        print("Error fetching orders $e ");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: orders.isEmpty
          ? Center(child: Text("No Orders Found"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final Order order = orders[index];
                return Column(
                  children: [
                    ListTile(
                      title: Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                order.image,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  order.productName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Text(order.category),

                                Text(
                                  "${order.productPrice}",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            Stack(
                              children:[ Positioned(
                                top: 380,
                                left: 500,
                                child: order.delivered
                                    ? Text(
                                        "✅Delivered",
                                        style: TextStyle(
                                          color: Colors.green,fontSize: 14,
                                          ),
                                      )
                                    : Text(
                                        "Not Delivered",
                                        style: TextStyle(color: Colors.pink, fontSize: 10,),
                                      ),
                              ),
                              ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

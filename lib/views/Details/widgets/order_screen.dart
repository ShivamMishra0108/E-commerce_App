import 'package:e_commerce_app/controllers/orderController.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/provider/order_provider.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/views/Details/screen/order_detail_screen.dart';
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

  Future<void> _deleteOrder(String id) async {
    final OrderController _orderController = OrderController();

    try {
      await _orderController.deleteOrders(id: id, context: context);
      fetchOrders();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
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
                    Image.asset(
                      "assets/icons/not.png",
                      height: 25,
                      width: 25,
                      color: Colors.black,
                    ),
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
                            orders.length.toString(),
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
                left: 60,
                top: 51,
                child: Text(
                  "My Orders",
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.black,
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
            ],
          ),
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
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderDetailScreen(order: order);
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    order.productName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(order.category),

                                  Text(
                                    "${order.productPrice}",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 14,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            order.processing
                                                ? "Processing"
                                                : "OrderPlaced",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    order.delivered
                                        ? Text(
                                            "delivered",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13,
                                            ),
                                          )
                                        : Text(
                                            "Not Delivered",
                                            style: TextStyle(
                                              color: Colors.pink,
                                              fontSize: 13,
                                            ),
                                          ),

                                    InkWell(
                                      onTap: () {
                                        _deleteOrder(order.id);
                                      },
                                      child: Image.asset(
                                        "assets/icons/delete.png",
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
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

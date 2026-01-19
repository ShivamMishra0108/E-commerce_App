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
  void initState (){
    super.initState();
    fetchOrders();
  }

Future<void> fetchOrders()async{
  final user = ref.read(userProvider);

  if(user != null){
    OrderController orderController = OrderController();

    try {
      final orders = await orderController.loadOrders(buyerId: user.id);
      ref.read(orderProvider.notifier).setOrders(orders);
    } catch (e) {
      print("Error fetching orders $e");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    return Scaffold(
      body: orders.isEmpty?
      Center(child: Text("No Orders Found"),
      ):
      ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index){
        final Order order = orders[index];
        return ListTile(
          title:  Text(order.productName),
        );
      })
    );
  }
}
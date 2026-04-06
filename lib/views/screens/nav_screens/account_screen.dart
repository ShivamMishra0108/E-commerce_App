import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/provider/favourite_provider.dart';
import 'package:e_commerce_app/provider/order_provider.dart';
import 'package:e_commerce_app/views/Details/screen/settings.dart';
import 'package:e_commerce_app/views/Details/screen/shipping_address_screen.dart';
import 'package:e_commerce_app/views/Details/widgets/order_screen.dart';
import 'package:e_commerce_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  AccountScreen({super.key});

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritesMap = ref.watch(favouriteProvider);
    final int favouritesCount = favouritesMap.length;
    final orderMap = ref.watch(orderProvider);
    final int ordersCount = orderMap.length;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildProfileHeader()),
          SliverToBoxAdapter(
          child: _buildStatsSection(ordersCount, favouritesCount)),
          SliverToBoxAdapter(child: _buildMenuSection(context)),
          SliverToBoxAdapter(child: _buildLogoutButton(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  // 🌟 APP BAR
  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      backgroundColor: Colors.blue,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text('My Account'),
        centerTitle: true,
      ),
    );
  }

  // 👤 PROFILE HEADER
  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 15),
          const Text(
            "Aman Sharma",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "aman@email.com",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          const Text(
            "Bhopal, Madhya Pradesh",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 📊 STATS SECTION (UPDATED)
  Widget _buildStatsSection(int favouritesCount, int ordersCount) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(ordersCount.toString(), "Orders"),
          _buildStatItem(favouritesCount.toString(), "Wishlist"), 
          _buildStatItem("5", "Coupons"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String title) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // ⚙️ MENU SECTION
  Widget _buildMenuSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          _buildMenuCard(
            icon: Icons.shopping_bag,
            title: "My Orders",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OrderScreen()),
              );
            },
          ),
          _buildMenuCard(
            icon: Icons.location_on,
            title: "Addresses",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShippingAddressScreen()),
              );
            },
          ),
          _buildMenuCard(
            icon: Icons.payment,
            title: "Payment Methods",
            onTap: () {},
          ),
          _buildMenuCard(
            icon: Icons.favorite,
            title: "Wishlist",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoriteScreen()),
              );
            },
          ),
          _buildMenuCard(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
          _buildMenuCard(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // 🎨 MENU CARD
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // 🔴 LOGOUT BUTTON
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () async {
          await _authController.signOutUser(context: context);
        },
        child: const Text(
          "Logout",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [

            
            _buildSectionTitle("Notifications"),
            _buildSwitchTile("Push Notifications", true),
            _buildSwitchTile("Email Notifications", false),

            const SizedBox(height: 20),

            _buildSectionTitle("Account"),
            _buildMenuCard(
              icon: Icons.lock,
              title: "Change Password",
              onTap: () {},
            ),
            _buildMenuCard(
              icon: Icons.privacy_tip,
              title: "Privacy Settings",
              onTap: () {},
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("App Settings"),
            _buildMenuCard(
              icon: Icons.language,
              title: "Language",
              onTap: () {},
            ),
            _buildMenuCard(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              onTap: () {},
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("About"),
            _buildMenuCard(
              icon: Icons.info,
              title: "About App",
              onTap: () {},
            ),
            _buildMenuCard(
              icon: Icons.description,
              title: "Terms & Conditions",
              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

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

  Widget _buildSwitchTile(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Switch(
            value: value,
            onChanged: (val) {},
            activeColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
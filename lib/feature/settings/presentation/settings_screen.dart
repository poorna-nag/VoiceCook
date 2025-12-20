import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: false),
      body: Column(
        children: [
          _button(Icons.account_box, "Account", () {}),
          SizedBox(height: 20),
          _button(Icons.privacy_tip, "Privacy", () {}),
          SizedBox(height: 20),
          _button(Icons.image, "Avatar", () {}),
          SizedBox(height: 20),
          _button(Icons.list, "List", () {}),
          SizedBox(height: 20),
          _button(Icons.chat, "Chat", () {}),
          SizedBox(height: 20),
          _button(Icons.broadcast_on_home, "Brodcase", () {}),
          SizedBox(height: 20),
          _button(Icons.notification_add, "Notification", () {}),
          SizedBox(height: 20),
          _button(Icons.settings, "Setting", () {}),
          SizedBox(height: 20),
          _button(Icons.logout, "Log Out", () {
            
          }),
        ],
      ),
    );
  }
}

Widget _button(IconData icon, String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 34, 108, 100),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickslot_app/controllers/auth_controller.dart';
import 'package:quickslot_app/screens/venues/venue_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  final users = [
    {"id": "user1", "name": "User 1"},
    {"id": "user2", "name": "User 2"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QuickSlot")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          final user = users[index];

          return ListTile(
            title: Text(user['name']!),
            onTap: () {
              authController.selectUser(id: user['id']!, name: user['name']!);

              Get.to(() => VenueListScreen());
            },
          );
        },
      ),
    );
  }
}

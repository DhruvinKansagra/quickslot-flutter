import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickslot_app/screens/login/login_screen.dart';

import 'controllers/auth_controller.dart';
import 'controllers/venue_controller.dart';

void main() {
  Get.put(AuthController());
  Get.put(VenueController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

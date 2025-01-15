import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // TextEditingController to manage user input for email and password
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Dummy login logic (replace with actual authentication logic)
  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in both fields');
      return;
    }

    // Dummy credentials check (replace with actual authentication logic)
    if (username == "test@example.com" && password == "password123") {
      Get.snackbar('Success', 'Logged in successfully');
      // Navigate to the home page after login
      Get.offNamed('/home');  // Update with your home screen route
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }
}

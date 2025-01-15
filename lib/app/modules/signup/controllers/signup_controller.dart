import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Dummy sign-up logic (you can replace this with actual logic)
  void signUp() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in both fields');
      return;
    }

    // Dummy check for successful sign-up (replace with actual authentication logic)
    if (username.contains('@') && password.length >= 6) {
      Get.snackbar('Success', 'Signed up successfully');
      Get.offNamed('/home');  // Navigate to the home page after sign-up
    } else {
      Get.snackbar('Error', 'Please provide a valid email and password');
    }
  }
}

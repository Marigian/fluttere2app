import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';  // Import the SignUpController

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),  // App name as the title for sign-up
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Username (Email) TextField with People Icon
            TextField(
              controller: controller.usernameController,
              decoration: InputDecoration(
                labelText: 'Username (Email)',
                prefixIcon: const Icon(Icons.person),  // People icon before username
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Password TextField with Key Icon
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),  // Key icon before password
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up Button (Turquoise background with white letters)
            ElevatedButton(
              onPressed: controller.signUp,  // Calls the signUp method from the controller
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),  // White letters
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1ABC9C),  // Turquoise color
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  // Rounded corners
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Already have an account? Login Link
            TextButton(
              onPressed: () {
                // Navigate to login screen
                Get.toNamed('/login');
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';  // Import the LoginController

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helping Hand'),  // App name as the title
        centerTitle: true,  // Center the app name
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

            // Login Button (Turquoise background with white letters)
            ElevatedButton(
              onPressed: controller.login,  // Calls the login method from the controller
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),  // White letters
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1ABC9C),  // Turquoise color (hex value for turquoise)
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  // Rounded corners
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Forgot Password Link (optional)
            TextButton(
              onPressed: () {
                // Navigate to forgot password screen (you can create this screen)
                Get.toNamed('/forgot-password');
              },
              child: const Text('Forgot password?'),
            ),

            // Sign Up Link (Navigate to the Sign Up screen)
            TextButton(
              onPressed: () {
                // Navigate to the Sign-Up screen
                Get.toNamed('/signup');
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

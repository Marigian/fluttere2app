import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Reactive variables for checkboxes
  var meteorologicalPrediction = false.obs;
  var fieldManagement = false.obs;
  var userProtectionMeasurements = false.obs;
  var biologicalData = false.obs;
  var smartWatchConnection = false.obs;

  // Set initial value of dropdowns to null
  var selectedAge = Rx<String?>(null);
  var selectedGender = Rx<String?>(null);
  var selectedRole = Rx<String?>(null);
  var selectedView = Rx<String?>(null);

  // Dummy sign-up logic
  void signUp() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in both fields');
      return;
    }

    if (username.contains('@') && password.length >= 6) {
      Get.snackbar('Success', 'Signed up successfully');
      Get.offNamed('/home');  // Navigate to the home page after sign-up
    } else {
      Get.snackbar('Error', 'Please provide a valid email and password');
    }
  }

  // Clear all fields and selections
  void clearFields() {
    usernameController.clear();  // Clear the username field
    passwordController.clear();  // Clear the password field
    selectedAge.value = null;  // Reset the Age dropdown
    selectedGender.value = null;  // Reset the Gender dropdown
    selectedRole.value = null;  // Reset the Role dropdown
    selectedView.value = null;  // Reset the View dropdown

    // Reset the checkboxes
    meteorologicalPrediction.value = false;
    fieldManagement.value = false;
    userProtectionMeasurements.value = false;
    biologicalData.value = false;
    smartWatchConnection.value = false;
  }
}

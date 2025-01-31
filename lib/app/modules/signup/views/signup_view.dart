import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart'; // Import Logger package
import '../controllers/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  // Initialize the logger
  static final Logger logger = Logger();

  // Function to check password strength
  String _checkPasswordStrength(String password) {
    if (password.length < 6) {
      return "Too short";
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$').hasMatch(password)) {
      return "Weak (Use uppercase, numbers, and symbols)";
    }
    return "Strong";
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final RxString passwordStrength = "".obs; // Observable for password strength tracking

    logger.i("SignUpView: Widget build called."); // Log when the widget builds

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Username (Email) TextField
            TextField(
              controller: controller.usernameController,
              decoration: InputDecoration(
                labelText: 'Username (Email)',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                logger.d("Username changed: $value");

                // Log duplicate email notification
                if (value.trim().toLowerCase() == "test@example.com") {
                  logger.e("The email already exists");
                }
              },
            ),
            const SizedBox(height: 20),

            // Password TextField with Strength Validation
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    passwordStrength.value = _checkPasswordStrength(value);
                    logger.d("Password updated. Strength: ${passwordStrength.value}");

                    if (passwordStrength.value == "Too short" || passwordStrength.value == "Weak (Use uppercase, numbers, and symbols)") {
                      logger.w("Weak password entered: $value");
                    }
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  "Password Strength: ${passwordStrength.value}",
                  style: TextStyle(
                    color: passwordStrength.value == "Strong"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            )),
            const SizedBox(height: 20),

            // Age and Gender Dropdowns
            Row(
              children: [
                // Age Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedAge.value,
                    onChanged: (newValue) {
                      logger.d("Age selected: $newValue");
                      controller.selectedAge.value = newValue!;
                    },
                    hint: Text('Select Age', style: theme.textTheme.bodySmall),
                    items: ['Under 18', '18-35', '35+']
                        .map((age) => DropdownMenuItem<String>(
                      value: age,
                      child: Text(age, style: theme.textTheme.bodySmall),
                    ))
                        .toList(),
                  ),
                ),
                SizedBox(width: 20.w),

                // Gender Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedGender.value,
                    onChanged: (newValue) {
                      logger.d("Gender selected: $newValue");
                      controller.selectedGender.value = newValue!;
                    },
                    hint: Text('Select Gender', style: theme.textTheme.bodySmall),
                    items: ['Male', 'Female', 'Rather not say']
                        .map((gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender, style: theme.textTheme.bodySmall),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Services Checkboxes with Logging
            const Text(
              'Select Services',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Obx(() => CheckboxListTile(
                  value: controller.meteorologicalPrediction.value,
                  onChanged: (bool? value) {
                    logger.d("Meteorological Prediction selected: $value");
                    controller.meteorologicalPrediction.value = value!;
                  },
                  title: const Text("Meteorological prediction"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.fieldManagement.value,
                  onChanged: (bool? value) {
                    logger.d("Field Management selected: $value");
                    controller.fieldManagement.value = value!;
                  },
                  title: const Text("Field management"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.userProtectionMeasurements.value,
                  onChanged: (bool? value) {
                    logger.d("User Protection Measurements selected: $value");
                    controller.userProtectionMeasurements.value = value!;
                  },
                  title: const Text("User protection measurements"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.biologicalData.value,
                  onChanged: (bool? value) {
                    logger.d("Biological Data selected: $value");
                    controller.biologicalData.value = value!;
                  },
                  title: const Text("Biological data"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.smartWatchConnection.value,
                  onChanged: (bool? value) {
                    logger.d("Smartwatch Connection selected: $value");
                    controller.smartWatchConnection.value = value!;
                  },
                  title: const Text("Connection with smart watch"),
                )),
              ],
            ),
            const SizedBox(height: 20),

            // Buttons with Logging
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    logger.i("Clear fields button clicked.");
                    controller.clearFields();
                  },
                  child: const Text('Delete All'),
                ),
                SizedBox(width: 20.w),
                ElevatedButton(
                  onPressed: () {
                    logger.i("Sign-up button clicked.");
                    controller.signUp();
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

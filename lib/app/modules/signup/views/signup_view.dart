import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/signup_controller.dart';  // Import the SignUpController

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;  // Get the current theme (this allows us to use the same primary color)

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',  // App name as the title for sign-up
          style: TextStyle(
            fontFamily: 'Comic Sans MS',  // Specify the system font (Comic Sans MS or another installed font)
            fontSize: 30.sp,  // Bigger font size
            fontWeight: FontWeight.bold,  // Bold style
            color: Colors.purple,  // Purple color
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

            // Age Dropdown (Fixing overflow)
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      isDense: true,  // Makes the dropdown more compact
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),  // Reduce padding inside the dropdown
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedAge.value,
                    onChanged: (newValue) {
                      controller.selectedAge.value = newValue!;
                    },
                    hint: Text('Select Age', style: theme.textTheme.bodySmall),  // Smaller text size for hint
                    items: [
                      'Under 18',
                      '18-35',
                      '35+',
                    ]
                        .map((age) => DropdownMenuItem<String>(
                      value: age,
                      child: Text(age, style: theme.textTheme.bodySmall),  // Smaller text size for items
                    ))
                        .toList(),
                  ),
                ),
                SizedBox(width: 20.w),  // Spacer

                // Gender Dropdown
                Container(
                  width: 150.w,  // Set a fixed width for the dropdown to avoid overflow
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedGender.value,
                    onChanged: (newValue) {
                      controller.selectedGender.value = newValue!;
                    },
                    hint: Text('Select Gender', style: theme.textTheme.bodySmall),
                    items: [
                      'Male',
                      'Female',
                      'Rather not say',
                    ]
                        .map((gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender, style: theme.textTheme.bodySmall),
                    ))
                        .toList(),
                  ),
                ),
                SizedBox(width: 20.w),  // Spacer

                // Role Dropdown (Fixing overflow)
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Role',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedRole.value,
                    onChanged: (newValue) {
                      controller.selectedRole.value = newValue!;
                    },
                    hint: Text('Select Role', style: theme.textTheme.bodySmall),
                    items: [
                      'Manager',
                      'Worker',
                    ]
                        .map((role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(role, style: theme.textTheme.bodySmall),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Select View Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select View',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                border: OutlineInputBorder(),
              ),
              value: controller.selectedView.value,
              onChanged: (newValue) {
                controller.selectedView.value = newValue!;
              },
              hint: Text('Select View', style: theme.textTheme.bodySmall),
              items: [
                'Vertical',
                'Horizontal',
              ]
                  .map((view) => DropdownMenuItem<String>(
                value: view,
                child: Text(view, style: theme.textTheme.bodySmall),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Select Services Label
            const Text(
              'Select Services',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Checkboxes for Services
            Column(
              children: [
                Obx(() => CheckboxListTile(
                  value: controller.meteorologicalPrediction.value,
                  onChanged: (bool? value) {
                    controller.meteorologicalPrediction.value = value!;
                  },
                  title: const Text("Meteorological prediction"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.fieldManagement.value,
                  onChanged: (bool? value) {
                    controller.fieldManagement.value = value!;
                  },
                  title: const Text("Field management"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.userProtectionMeasurements.value,
                  onChanged: (bool? value) {
                    controller.userProtectionMeasurements.value = value!;
                  },
                  title: const Text("User protection measurements"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.biologicalData.value,
                  onChanged: (bool? value) {
                    controller.biologicalData.value = value!;
                  },
                  title: const Text("Biological data"),
                )),
                Obx(() => CheckboxListTile(
                  value: controller.smartWatchConnection.value,
                  onChanged: (bool? value) {
                    controller.smartWatchConnection.value = value!;
                  },
                  title: const Text("Connection with smart watch"),
                )),
              ],
            ),
            const SizedBox(height: 20),

            // Buttons for Deleting and Signing Up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Delete All" Button with same style as "Sign Up"
                ElevatedButton(
                  onPressed: () {
                    // Clear all selections and inputs
                    controller.clearFields();
                  },
                  child: const Text('Delete All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,  // Same color as "Get Started" button
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),  // Rounded corners
                    ),
                  ),
                ),
                SizedBox(width: 20.w),  // Spacer
                ElevatedButton(
                  onPressed: controller.signUp,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,  // Same color as "Get Started"
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

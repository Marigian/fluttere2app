import 'package:get/get.dart';
import '../controllers/signup_controller.dart';  // Import the SignUpController

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the SignUpController
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}

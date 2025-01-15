import 'package:get/get.dart';
import '../controllers/login_controller.dart';  // Import the LoginController

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the LoginController
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

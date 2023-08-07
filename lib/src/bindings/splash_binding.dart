import 'package:get/get.dart';
import 'package:saudi_adaminnovations/src/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

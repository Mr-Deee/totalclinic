import 'package:get/get.dart';

import '../Controller/auth_controller.dart';
import '../auth_services.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthBinding>(
    //   () => AuthBinding(),
    // );

    Get.put(AuthService());
    Get.put(AuthController());
  }
}

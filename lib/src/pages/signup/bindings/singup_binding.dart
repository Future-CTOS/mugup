import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SingupBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SignupController());
}
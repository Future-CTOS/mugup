import 'package:get/get.dart';

import '../controller/details_product_controller.dart';

class DetailsProductBinding extends Bindings {
  @override
  void dependencies() {
    final int? productId = int.tryParse(Get.parameters['id'] ?? '');

    Get.lazyPut(() => DetailsProductController(productId: productId));
  }
}

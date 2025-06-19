import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/details_product_controller.dart';

class DetailsProductPage extends GetView<DetailsProductController> {
  const DetailsProductPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Customize Order')),
    body: Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      }
      final product = controller.detailsProduct;
      if (product == null) {
        return const Text('No product found.');
      }

      return Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height / 2,
            child: ColoredBox(color: context.theme.disabledColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (product.avatar != null)
                Positioned(child: Image.memory(product.avatar!)),
              Text(product.title),
            ],
          ),
        ],
      );
    }),
  );
}

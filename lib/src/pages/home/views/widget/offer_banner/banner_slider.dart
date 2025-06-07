import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controllers/home_page_controller.dart';
import 'banner_item.dart';

class BannerSlider extends GetView<HomePageController> {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) => PageView.builder(
    controller: controller.pageController,
    itemCount: controller.offerBanners.length,
    onPageChanged: controller.onBannerChange,
    itemBuilder: (_, index) {
      final bytes = controller.offerBanners[index].imageBytes;
      return BannerItem(bytes: bytes);
    },
  );
}

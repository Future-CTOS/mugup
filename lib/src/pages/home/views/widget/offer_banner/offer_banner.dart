import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_page_controller.dart';
import 'banner_slider.dart';
import 'navigation_controls.dart';

class OfferBanner extends GetView<HomePageController> {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) => Obx(
    () => MouseRegion(
      onHover: controller.onBannerHover,
      onExit: controller.onBannerHoverExit,
      child: SizedBox(
        width: context.width,
        height: context.height / 3,
        child: Stack(
          children: [
            BannerSlider(),
            if (controller.isOnDesktopAndWeb)
              NavigationControls(isHovered: controller.isBannerHovered.value),
          ],
        ),
      ),
    ),
  );
}

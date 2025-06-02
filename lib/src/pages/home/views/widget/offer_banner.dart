import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_page_controller.dart';

class OfferBanner extends GetView<HomePageController> {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      PageView.builder(
        controller: controller.pageController,
        onPageChanged:
            (final pageNumber) => controller.currentPage.value = pageNumber,
        itemCount: controller.offerBanners.length,
        itemBuilder: (context, index) {
          // SvgPicture.asset(controller.offerBanners[index].url);
          return Text('${controller.offerBanners[index].id}');
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../controllers/home_page_controller.dart';
import 'navigation_button.dart';

class NavigationControls extends GetView<HomePageController> {
  const NavigationControls({super.key, required this.isHovered});

  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Positioned(
      right: Utils.semiLargeSpace,
      bottom: Utils.giantSpace,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: isHovered ? 1 : 0,
        child: Row(
          children: [
            NavigationButton(
              icon: isRtl ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
              onTap:
                  isRtl
                      ? controller.onNavigateToNextBanner
                      : controller.onNavigateToPreviousBanner,
            ),
            Utils.mediumHorizontalSpace,
            NavigationButton(
              icon: isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              onTap:
                  isRtl
                      ? controller.onNavigateToPreviousBanner
                      : controller.onNavigateToNextBanner,
            ),
          ],
        ),
      ),
    );
  }
}

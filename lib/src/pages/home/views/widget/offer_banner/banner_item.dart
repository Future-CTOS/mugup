import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../controllers/home_page_controller.dart';

class BannerItem extends GetView<HomePageController> {
  const BannerItem({super.key, required this.bytes});

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) => Container(
    margin: Utils.smallPadding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Utils.mediumSpace),
      image: DecorationImage(image: MemoryImage(bytes), fit: BoxFit.cover),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: TabPageSelector(
        controller: controller.tabController,
        selectedColor: context.theme.primaryColor,
        color: Colors.white,
        borderStyle: BorderStyle.none,
      ),
    ),
  );
}

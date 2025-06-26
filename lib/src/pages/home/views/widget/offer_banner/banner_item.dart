import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    required this.tabController,
    required this.bytes,
  });

  final Uint8List bytes;
  final TabController tabController;

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
        controller: tabController,
        selectedColor: context.theme.primaryColor,
        color: Colors.white,
        borderStyle: BorderStyle.none,
      ),
    ),
  );
}

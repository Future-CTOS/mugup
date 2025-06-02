import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controllers/home_page_controller.dart';
import 'widget/offer_banner.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      SafeArea(child: Scaffold(body: _content(context)));

  Padding _content(BuildContext context) => Padding(
    padding: Utils.mediumPadding,
    child: Column(
      children: [
        _appBar(context),
        Utils.mediumVerticalSpace,
        OfferBanner(),
        // Expanded(
        //   child: CarouselView(
        //     controller: CarouselController(),
        //     backgroundColor: Colors.red,
        //     itemExtent: 80,
        //     children: a.map((e) => Text(e)).toList(),
        //   ),
        // ),
      ],
    ),
  );

  Widget _appBar(BuildContext context) => Row(
    spacing: Utils.largeSpace,
    children: [
      Expanded(
        child: TextField(
          controller: controller.textController,
          decoration: InputDecoration(
            hintText: 'What would you like to drink?',
            hintStyle: Theme.of(context).textTheme.titleSmall,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 12),
              child: SvgPicture.asset(Assets.svg.search),
            ),
          ),
        ),
      ),
      Icon(CupertinoIcons.bell, color: Color(0xff5D4037)),
    ],
  );
}

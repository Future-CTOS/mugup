import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controllers/home_page_controller.dart';
import 'widget/offer_banner/offer_banner.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      SafeArea(child: Scaffold(body: _content(context)));

  Padding _content(BuildContext context) => Padding(
    padding: Utils.semiLargePadding,
    child: Column(
      children: [
        _appBar(context),
        Utils.mediumVerticalSpace,
        Expanded(child: OfferBanner()),
        Text('data'),
      ],
    ),
  );

  Widget _appBar(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: Utils.largeSpace,
      children: [
        Expanded(
          child: TextField(
            controller: controller.textController,
            decoration: InputDecoration(
              hintText: 'What would you like to drink?',
              hintStyle: theme.textTheme.titleSmall,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.primaryColor,
                  strokeAlign: 20,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Utils.largeSpace),
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: Utils.semiLargeSpace),
                child: SvgPicture.asset(Assets.svg.search),
              ),
            ),
          ),
        ),
        Icon(CupertinoIcons.bell, color: theme.primaryColor),
      ],
    );
  }
}

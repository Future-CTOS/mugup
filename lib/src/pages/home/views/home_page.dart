import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mugup/src/pages/home/views/widget/hom_page_bottom_navigation.dart';

import '../../../../gen/assets.gen.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controllers/home_page_controller.dart';
import '../models/enum/menu_category.dart';
import 'widget/coffee_type_tab_bar.dart';
import 'widget/menu_items.dart';
import 'widget/offer_banner/offer_banner.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Padding(
        padding: Utils.semiLargePadding,
        child: Obx(
          () => IgnorePointer(
            ignoring:
                controller.isItemsLoading.value || controller.isLoading.value,
            child: _content(context),
          ),
        ),
      ),
    ),
  );

  Widget _content(final BuildContext context) => SizedBox(
    height: context.height,
    width: context.width,
    child: Column(
      children: [
        _appBar(context),
        Utils.mediumVerticalSpace,
        controller.isOfferBannerVisible
            ? Expanded(flex: 1, child: OfferBanner())
            : SizedBox.shrink(),
        Utils.mediumVerticalSpace,
        Expanded(
          flex: 3,
          child: CoffeeTypeTabBar(
            tabController: controller.tabBarCoffeeTypeController,
            tabViews: _tabViews(),
          ),
        ),
      ],
    ),
  );

  List<Widget> _tabViews() => List.generate(
    MenuCategory.values.length,
    (index) => Obx(
      () => MenuItems(
        scrollController: controller.scrollPageController,
        items: controller.menuItems,
        isLoading: controller.isItemsLoading.value,
        getMenuItems: controller.checkForUpdateItems,
      ),
    ),
  );

  Widget _appBar(final BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(height: kToolbarHeight, child: _appBarContent(theme));
  }

  Widget _appBarContent(ThemeData theme) => Row(
    spacing: Utils.largeSpace,
    children: [
      Expanded(
        child: TextField(
          controller: controller.textController,
          decoration: InputDecoration(
            hintText: 'What would you like to drink?',
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

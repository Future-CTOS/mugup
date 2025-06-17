import 'package:flutter/material.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../models/enum/menu_category.dart';
import 'filter_product_bar.dart';

class CoffeeTypeTabBar extends StatelessWidget {
  const CoffeeTypeTabBar({
    super.key,
    required this.tabController,
    required this.tabViews,
  });

  final TabController tabController;
  final List<Widget> tabViews;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      tabBar(context),
      Utils.semiLargeVerticalSpace,
      FilterProductBar(),
      Expanded(
        child: TabBarView(controller: tabController, children: tabViews),
      ),
    ],
  );

  List<Widget> _tabs() =>
      MenuCategory.values.map((e) => Text(e.value)).toList();

  Widget tabBar(BuildContext context) =>
      TabBar(controller: tabController, tabs: _tabs());
}

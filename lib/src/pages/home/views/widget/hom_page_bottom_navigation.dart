import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';

class HomPageBottomNavigation extends StatelessWidget {
  const HomPageBottomNavigation({
    super.key,
    required this.onTapNavigationItem,
    required this.currentIndex,
  });

  final void Function(int) onTapNavigationItem;
  final int currentIndex;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: _decoration(context),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Utils.giantSpace),
        topRight: Radius.circular(Utils.giantSpace),
      ),
      child: buildBottomNavigationBar(),
    ),
  );

  BottomNavigationBar buildBottomNavigationBar() => BottomNavigationBar(
    onTap: onTapNavigationItem,
    currentIndex: currentIndex,
    items: [
      _item(icon: CupertinoIcons.home, title: 'Home', tooltip: 'home screen'),
      _item(
        icon: Icons.article_outlined,
        title: 'History',
        tooltip: 'history of your orders',
      ),
      _item(icon: Icons.person_outline_rounded, title: 'Account'),
    ],
  );

  BottomNavigationBarItem _item({
    required IconData icon,
    required String title,
    String? tooltip,
  }) =>
      BottomNavigationBarItem(icon: Icon(icon), label: title, tooltip: tooltip);

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
    boxShadow: [
      BoxShadow(
        blurRadius: 2,
        color: context.theme.disabledColor.withValues(alpha: 0.5),
      ),
    ],
    color: context.theme.disabledColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Utils.giantSpace),
      topRight: Radius.circular(Utils.giantSpace),
    ),
  );
}

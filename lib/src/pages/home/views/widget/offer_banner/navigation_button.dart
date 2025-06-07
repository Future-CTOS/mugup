import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NavigationButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    shape: const CircleBorder(),
    color: context.theme.secondaryHeaderColor,
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Padding(
        padding: Utils.semiLargePadding,
        child: Icon(icon, color: context.theme.primaryColor, size: 20),
      ),
    ),
  );
}

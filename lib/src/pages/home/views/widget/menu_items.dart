import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/routes/route_names/route_names.dart';
import '../../../../infrastructure/theme/theme_names.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../models/menu_item_view_model.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.scrollController,
    required this.items,
    required this.isLoading,
    required this.getMenuItems,
  });

  final Future<void> Function() getMenuItems;
  final ScrollController scrollController;
  final List<MenuItemViewModel> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(
        child: Text(
          'No items available',
          style: context.theme.textTheme.bodyMedium,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: getMenuItems,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap:
                  () => Get.toNamed(
                    RouteNames.detailsProduct,
                    parameters: {'id': '${item.id}'},
                  ),
              child: MenuItemTile(item: item),
            );
          },
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({super.key, required this.item});

  final MenuItemViewModel item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarWithRate(avatar: item.avatar, rate: item.rate),
          Utils.semiLargeHorizontalSpace,
          _titleWithDescription(theme),
          Utils.semiLargeHorizontalSpace,
          _priceSection(theme),
        ],
      ),
    );
  }

  Widget _titleWithDescription(ThemeData theme) => Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: theme.textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Utils.smallVerticalSpace,
        Text(
          item.description,
          style: theme.textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  Widget _priceSection(ThemeData theme) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Flexible(
        child: Text(
          '\$${item.price.toStringAsFixed(4)}',
          style: theme.textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      if (item.beforeDiscountedPrice != null) ...[
        Utils.smallVerticalSpace,
        Flexible(
          child: Text(
            '\$${item.beforeDiscountedPrice}',
            style: theme.textTheme.bodyMedium!.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ],
  );
}

class AvatarWithRate extends StatelessWidget {
  const AvatarWithRate({super.key, required this.avatar, required this.rate});

  final Uint8List? avatar;
  final double rate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.disabledColor,
            shape: BoxShape.circle,
          ),
          child:
              avatar != null
                  ? ClipOval(child: Image.memory(avatar!, fit: BoxFit.cover))
                  : const Icon(
                    Icons.emoji_food_beverage,
                    size: 48,
                    color: ThemeNames.primaryColor,
                  ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Utils.semiLargeSpace),
              color: ThemeNames.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Utils.smallSpace,
              vertical: Utils.tinySpace,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  color: ThemeNames.goldenColor,
                  size: 12,
                ),
                Utils.tinyHorizontalSpace,
                Text(rate.toStringAsFixed(1), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

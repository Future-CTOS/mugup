import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme_names.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../models/menu_item_view_model.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.scrollController,
    required this.items,
    required this.isLoading,
  });

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

    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return MenuItemTile(item: item);
      },
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
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
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: Utils.mediumPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWithRate(avatar: item.avatar, rate: item.rate),
            const SizedBox(width: 12),
            Expanded(
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
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarWithRate extends StatelessWidget {
  const AvatarWithRate({
    super.key,
    required this.avatar,
    required this.rate,
  });

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
          child: avatar != null
              ? ClipOval(child: Image.memory(avatar!, fit: BoxFit.cover))
              : const Icon(
            CupertinoIcons.person_crop_circle_fill,
            size: 48,
            color: Colors.grey,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Utils.semiLargeSpace),
              color: ThemeNames.whiteColor,
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
              vertical: Utils.smallSpace / 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  color: ThemeNames.goldenColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  rate.toStringAsFixed(1),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../controllers/home_page_controller.dart';
import '../../models/enum/product_filter_category.dart';

class FilterProductBar extends GetView<HomePageController> {
  const FilterProductBar({super.key});

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = context.theme;
    return SizedBox(
      width: context.width,
      height: 35,
      child: Obx(
        () => Row(
          children: [
            _filterButton(theme: theme),
            Utils.mediumHorizontalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: ProductFilterCategory.values.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, _) => Utils.mediumHorizontalSpace,
                itemBuilder: (final context, final index) {
                  final filterCategory = ProductFilterCategory.values[index];
                  return _filterItem(
                    theme: theme,
                    context: context,
                    filterCategory: filterCategory,
                    onTap:
                        () => controller.onTapFilterProductItem(
                          filterCategory.id,
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton({required ThemeData theme}) => IgnorePointer(
    child: Container(
      padding: Utils.mediumPadding,
      decoration: BoxDecoration(
        color:
            controller.isFilterButtonSelected
                ? theme.primaryColor
                : theme.disabledColor,
        borderRadius: BorderRadius.circular(Utils.semiLargeSpace),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.filter_alt_outlined,
            size: 16,
            color:
                controller.isFilterButtonSelected
                    ? theme.secondaryHeaderColor
                    : theme.textTheme.labelMedium?.color,
          ),
          Utils.smallHorizontalSpace,
          Flexible(
            child: Text(
              'Filter',
              style:
                  controller.isFilterButtonSelected
                      ? theme.textTheme.labelMedium?.copyWith(
                        color: theme.secondaryHeaderColor,
                      )
                      : theme.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _filterItem({
    required ThemeData theme,
    required ProductFilterCategory filterCategory,
    required VoidCallback onTap,
    required BuildContext context,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(Utils.semiLargeSpace),
    child: Container(
      width: context.width / ProductFilterCategory.values.length,
      padding: Utils.mediumPadding,
      decoration: BoxDecoration(
        color:
            controller.isSelectedFilterItem(filterCategory.id)
                ? theme.primaryColor
                : theme.disabledColor,
        borderRadius: BorderRadius.circular(Utils.semiLargeSpace),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            filterCategory.icon,
            size: 16,
            color:
                controller.isSelectedFilterItem(filterCategory.id)
                    ? theme.secondaryHeaderColor
                    : theme.textTheme.labelMedium?.color,
          ),
          Utils.tinyHorizontalSpace,
          Flexible(
            child: Text(
              filterCategory.label,
              style:
                  controller.isSelectedFilterItem(filterCategory.id)
                      ? theme.textTheme.labelMedium?.copyWith(
                        color: theme.secondaryHeaderColor,
                      )
                      : theme.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    ),
  );
}

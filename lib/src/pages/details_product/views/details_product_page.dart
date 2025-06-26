import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/mugup_counter.dart';
import '../../../infrastructure/theme/theme_names.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controller/details_product_controller.dart';
import '../models/details_product_view_model.dart';

class DetailsProductPage extends GetView<DetailsProductController> {
  const DetailsProductPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _appBar(),
    body: Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      }
      final product = controller.detailsProduct;
      if (product == null) {
        return const Text('No product found.');
      }

      return Stack(
        alignment: Alignment.topCenter,
        children: [
          _pictureBackground(context, avatar: product.avatar),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_details(context, product), _options(context)],
          ),
        ],
      );
    }),
  );

  Widget _details(BuildContext context, DetailsProductViewModel product) =>
      Container(
        margin: Utils.semiLargePadding,
        padding: Utils.mediumPadding,
        decoration: _decoration(context),
        child: Column(
          spacing: Utils.mediumSpace,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Coffee', style: context.theme.textTheme.headlineMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
                Text(
                  Utils.showProductPrice(product.price),
                  style: context.theme.textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    product.description,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ),
                Flexible(child: MugupCounter(maxNumber: 100, minNumber: 1)),
              ],
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  color: ThemeNames.goldenColor,
                  size: 12,
                ),
                Utils.tinyHorizontalSpace,
                Text(
                  product.rate.toStringAsFixed(1),
                  style: context.theme.textTheme.bodySmall,
                ),
                Utils.smallHorizontalSpace,
                Text('(23)', style: context.theme.textTheme.bodyMedium),
                Utils.semiLargeHorizontalSpace,
                Expanded(
                  child: Text(
                    'Ratings and reviews',
                    style: context.theme.textTheme.bodyMedium,
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ],
        ),
      );

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
    color: context.theme.secondaryHeaderColor,
    borderRadius: Utils.normalCircularRadius,
    boxShadow: [
      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4),
    ],
  );

  AppBar _appBar() => AppBar(title: Text('Customize Order'));

  Widget _options(BuildContext context) => Container(
    margin: Utils.semiLargePadding,
    padding: Utils.mediumPadding,
    height: context.height / 2,
    decoration: _decoration(context),
    child: Column(
      spacing: Utils.mediumSpace,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customize', style: context.theme.textTheme.displaySmall),
        Expanded(
          child: ListView.builder(
            itemCount: controller.example2.length,
            itemBuilder:
                (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Variant',
                      style: context.theme.textTheme.displayMedium,
                    ),
                    Spacer(),
                    Wrap(
                      spacing: Utils.mediumSpace,
                      children:
                          controller.example
                              .map((e) => Text(e.toString()))
                              .toList(),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ListView.builder(
                        itemCount: 100,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Text('data'),
                      ),
                    ),
                  ],
                ),
            // separatorBuilder: (final _, final _) => Utils.smallVerticalSpace,
          ),
        ),
      ],
    ),
  );

  Widget _pictureBackground(
    BuildContext context, {
    required Uint8List? avatar,
  }) => SizedBox(
    width: context.width,
    height: context.height / 2,
    child: ColoredBox(
      color: context.theme.disabledColor,
      child: avatar != null ? Image.memory(avatar, fit: BoxFit.contain) : null,
    ),
  );
}

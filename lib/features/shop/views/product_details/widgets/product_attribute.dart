import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/chips/choice_chip.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_price_text.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/shop/controllers/products/product_variation_controller.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/texts/product_text/product_title_text.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductVariationController());

    return Obx(
        () => Column(
        children: [
          // ----- Selected Attribute Pricing and Description
          // Display price and stock of a variation when it is selected
          if (controller.selectedVariation.value.id.isNotEmpty)
            Column(
              children: [
                RoundedContainer(
                  padding: const EdgeInsets.all(AppSize.medium),
                  backgroundColor: isDark ? AppPallete.darkerGrey : AppPallete.greyColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== Title, Price, and Stock Status
                      const SectionHeading(title: 'Variations', showActionButton: false),
                      const SizedBox(height: AppSize.spaceBtwItems / 2),
                      Column(

                        children: [
                          // ----- Actual and Sale Price
                          Row(
                            children: [
                              const ProductTitle(title: 'Price:', smallSize: true),
                              const SizedBox(width: AppSize.spaceBtwItems / 2),

                              ProductPriceText(
                                price: controller.selectedVariation.value.price.toString(),
                                isLarge: !(controller.selectedVariation.value.salePrice > 0),
                                lineThrough: controller.selectedVariation.value.salePrice > 0,
                              ),
                              const SizedBox(width: AppSize.spaceBtwItems / 2),

                              if (controller.selectedVariation.value.salePrice > 0)
                                ProductPriceText(price: controller.getVariationPrice(), isLarge: true),
                            ],
                          ),
                          // ----- Stock Status
                          Row(
                            children: [
                              const ProductTitle(title: 'Status:', smallSize: true),
                              const SizedBox(width: AppSize.spaceBtwItems / 2),
                              ProductTitle(title: controller.getProductVariationStockStatus()),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.spaceBtwItems / 2),

                      // ----- Variation Description
                      ProductTitle(
                        title: controller.selectedVariation.value.description,
                        maxLines: 4,
                        smallSize: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
              ],
            ),

          // ----- Variation Attribute Values
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttribute!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: AppSize.spaceBtwItems / 2),
                      Obx(
                      () => Wrap(
                          spacing: AppSize.small,
                          children: attribute.values!.map((values) {
                              final isSelected = controller.selectedAttribute[attribute.name] == values;
                              final available = controller
                                  .getAttributeAvailabilityInVariation(product.productVariation!, attribute.name!)
                                  .contains(values);

                              return CustomChoiceChip(
                                label: values,
                                selected: isSelected,
                                onSelected: available
                                  ? (selected) {
                                     if (selected && available) {
                                       controller.onAttributeSelected(product, attribute.name, values);
                                     }
                                  } : null,
                              );
                            }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppSize.small),
                    ],
                  ),
                )
                .toList(),
          ),

          // ----- Colors
        ],
      ),
    );
  }
}

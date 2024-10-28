import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_quantity.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/features/shop/controllers/products/product_variation_controller.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../models/products/product_model.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    final variationController = ProductVariationController.instance;

    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.defaultSpace,
          vertical: AppSize.defaultSpace / 2,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppPallete.darkerGrey : AppPallete.softGrey,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppSize.cardRadiusLarge),
            topLeft: Radius.circular(AppSize.cardRadiusLarge),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ----- Increase & Decrease Product
            ProductQuantityWithAddRemoveButton(
              quantity: controller.productQuantityCartItem.value,
              add: () {
                if (product.productType == ProductType.single.toString()) {
                  if (controller.productQuantityCartItem.value >= product.stock) {
                    return;
                  } else {
                    controller.productQuantityCartItem.value += 1;
                  }
                }
                if (product.productType == ProductType.variable.toString()) {
                  if (controller.productQuantityCartItem.value >= variationController.selectedVariation.value.stock) {
                    return;
                  } else {
                    controller.productQuantityCartItem.value += 1;
                  }
                }
              },
              remove: () {
                if (controller.productQuantityCartItem.value <= 0) {
                  return;
                } else {
                  controller.productQuantityCartItem.value -= 1;
                }
              },
            ),

            // ----- Add to cart Button
            ElevatedButton(
              onPressed: () {
                controller.addToCart(product);
              },
              child: const Text('Add To Cart'),
            )
          ],
        ),
      );
    });
  }
}

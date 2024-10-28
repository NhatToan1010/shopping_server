import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../../../utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    required this.onPressed,
    this.applyDark = false,
  });

  final VoidCallback onPressed;
  final bool applyDark;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController());

    return Stack(
      children: [
        // ===== Icon
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag,
              color: applyDark
                  ? isDark
                      ? AppPallete.whiteColor
                      : AppPallete.blackColor
                  : AppPallete.whiteColor),
        ),
        if (controller.isLoading.value) const CustomShimmerEffect(width: 40, height: 40),
        // ===== Counter
        Positioned(
          top: 4,
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppPallete.darkerGrey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              // Need to implement Method
              child: Obx(
                () => Text(
                  controller.noOfCartItem.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: AppPallete.whiteColor, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

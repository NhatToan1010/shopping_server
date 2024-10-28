import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/features/shop/views/cart/cart_screen.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/product_cart/carts/cart_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return CustomAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalTexts.headerTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: AppPallete.greyColor),
          ),
          Obx(() {
            if (controller.isProfileLoading.value) {
              // --- Display a shimmer loader when user data is fetching
              return const CustomShimmerEffect(width: 150, height: 20);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: AppPallete.whiteColor),
              );
            }
          }),
        ],
      ),
      actions: [CartCounterIcon(onPressed: () => Get.to(() => const CartScreen()))],
    );
  }
}

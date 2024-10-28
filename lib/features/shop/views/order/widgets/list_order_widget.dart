import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/features/shop/models/order_model.dart';
import 'package:shopping_server/features/shop/views/order/widgets/order_detail.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class ListOrderWidget extends StatelessWidget {
  const ListOrderWidget({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => OrderDetail(order: order)),
      child: RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSize.medium),
        defaultBackgroundColor: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Shipping Status
            Row(
              children: [
                const Icon(Iconsax.truck, size: 24),
                const SizedBox(width: AppSize.small),
      
                // ----- Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderStatusText,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: HelperFunctions.isDarkMode(context)
                                  ? AppPallete.secondary
                                  : AppPallete.primary,
                              fontWeightDelta: 1,
                            ),
                      ),
                      Text(order.formattedOrderDate,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
      
                // ----- Icon More
                Icon(Icons.more_outlined,
                    size: 16,
                    color: HelperFunctions.isDarkMode(context)
                        ? AppPallete.greyColor
                        : AppPallete.darkGrey),
              ],
            ),
      
            const SizedBox(height: AppSize.spaceBtwItems),
      
            // ----- Order Code & Delivery Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ----- Order Code
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.tag, size: 24),
                      const SizedBox(width: AppSize.small),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(order.id,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      
                // ----- Delivery Date
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.calendar, size: 24),
                      const SizedBox(width: AppSize.small),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Delivery Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(order.formattedDeliveryDate,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.spaceBtwItems),
      
            // --- Delivery Address
            Row(
              children: [
                const Icon(Iconsax.location, size: 24),
                const SizedBox(width: AppSize.small),
      
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(order.deliveryAddress!.getAddress(),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

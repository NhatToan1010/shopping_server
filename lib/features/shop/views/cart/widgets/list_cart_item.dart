import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';

import '../../../../../common/widgets/product_cart/carts/cart_item.dart';
import '../../../../../common/widgets/product_cart/product_cards/product_quantity.dart';
import '../../../../../common/widgets/texts/product_text/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class ListCartItem extends StatelessWidget {
  const ListCartItem({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () {
        final listItem = controller.cartItems;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: listItem.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: AppSize.spaceBtwSections,
          ),
          itemBuilder: (_, index) => Obx(
            () {
              final cartItem = listItem[index];

              return Column(
                children: [
                  CartItem(
                    cartItem: listItem[index],
                  ),
                  if (showAddRemoveButton)
                    const SizedBox(height: AppSize.extraSmall),
                  if (showAddRemoveButton)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: DeviceUtils.getScreenWidth() * 0.15),

                            // ----- Add & Remove Button
                            ProductQuantityWithAddRemoveButton(
                              quantity: cartItem.quantity,
                              add: () => controller.increaseProductQuantity(cartItem),
                              remove: () => controller.reduceProductQuantity(cartItem),
                            ),
                          ],
                        ),

                        // ----- Price
                        ProductPriceText(price: (cartItem.price * cartItem.quantity).toStringAsFixed(1))
                      ],
                    ),

                  const SizedBox(height: AppSize.small),
                  const Divider()
                ],
              );
            },
          ),
        );
      },
    );
  }
}

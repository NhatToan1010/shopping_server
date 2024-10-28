import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/shop/controllers/products/cart_controller.dart';
import 'package:shopping_server/features/shop/views/product_details/product_details_screen.dart';
import 'package:shopping_server/utils/constants/enums.dart';

import '../../../../features/shop/models/products/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Obx(() {
      final productQuantity = controller.getProductQuantityInCart(product.id);
      return IconButton(
        style: IconButton.styleFrom(
          foregroundColor: AppPallete.whiteColor,
          backgroundColor: productQuantity > 0
              ? AppPallete.primary
              : AppPallete.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium),
          ),
        ),
        onPressed: () {
          // If the product type is variable, then user have to select product variations.
          // Else add the product to cart.
          if (product.productType == ProductType.single.toString()) {
            final cartItem = controller.convertToCartModel(product, 1);
            controller.increaseProductQuantity(cartItem);
          } else {
            Get.to(() => ProductDetailsScreen(product: product));
          }
        },
        icon: productQuantity > 0
            ? Text(
                productQuantity.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: AppPallete.whiteColor),
              )
            : const Icon(Iconsax.add),
      );
    });
  }
}

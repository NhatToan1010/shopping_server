import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/styles/shadows.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_card_add_to_cart_button.dart';
import 'package:shopping_server/features/shop/controllers/products/product_controller.dart';
import 'package:shopping_server/features/shop/views/product_details/product_details_screen.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../features/shop/models/products/product_model.dart';
import '../../icons/circular_icon.dart';
import '../../images/rounded_rect_image.dart';
import '../../texts/product_text/product_brand_text.dart';
import '../../texts/product_text/product_price_text.dart';
import '../../texts/product_text/product_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    this.productIndex,
  });

  final ProductModel? productIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercent = controller.getSaleDiscount(productIndex!.salePrice, productIndex!.price);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: productIndex!)),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            boxShadow: [isDark ? ShadowStyle.darkProductShadow : ShadowStyle.lightProductShadow],
            borderRadius: BorderRadius.circular(AppSize.productImageRadius),
            color: isDark ? AppPallete.backgroundDark : AppPallete.backgroundLight,
            border: Border.all(color: isDark ? AppPallete.softGrey : AppPallete.darkGrey, width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail, Wishlist, Discount

            // ----- Product Image -----
            RoundedContainer(
              height: 155,
              width: double.infinity,
              backgroundColor: isDark ? AppPallete.darkGrey : AppPallete.greyColor,
              child: Stack(
                children: [
                  RoundedRectImage(
                    width: double.infinity,
                    imageUrl: productIndex!.thumbnail, // Fetch Data
                    backgroundColor: isDark ? AppPallete.darkGrey : AppPallete.greyColor,
                    fit: BoxFit.cover,
                    isNetworkImage: true,
                    halfRadius: true,
                  ),

                  // ----- Discount -----
                  if (productIndex!.salePrice > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: RoundedContainer(
                        width: 40,
                        radius: AppSize.small,
                        padding: const EdgeInsets.all(AppSize.extraSmall),
                        backgroundColor: Colors.amberAccent,
                        child: Center(
                          child: Text(
                            '$salePercent%', // Fetch Data
                            style: Theme.of(context).textTheme.labelLarge!.apply(color: AppPallete.blackColor),
                          ),
                        ),
                      ),
                    ),

                  // ----- Wishlist Icon
                  Positioned(
                    right: 0,
                    child: CircularIcon(
                      icon: Iconsax.heart,
                      onPressed: () {},
                      iconColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),

            // ----- Product Details -----
            Padding(
              padding: const EdgeInsets.all(AppSize.small),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: isDark ? AppPallete.softGrey : AppPallete.darkGrey, ),
                  // ----- Product Name -----
                  ProductTitle(title: productIndex!.title, smallSize: false),
                  const SizedBox(height: AppSize.extraSmall),

                  // ----- Product Brand Verified -----
                  ProductBrandText(brandName: productIndex!.brand!.brandName),
                ],
              ),
            ),

            const Spacer(),

            // ------ Product Price & Button Add ------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ----- Product Price
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (productIndex!.productType == ProductType.single.toString() && productIndex!.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: AppSize.small),
                          child: ProductPriceText(
                            currencySign: '\$',
                            price: productIndex!.price.toString(),
                            isLarge: false,
                            lineThrough: true,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: AppSize.small, bottom: AppSize.extraSmall),
                        child: ProductPriceText(
                          currencySign: '',
                          price: controller.getProductPrice(productIndex!),
                        ),
                      ),
                    ],
                  ),
                ),

                // ----- Button -----
                ProductCardAddToCartButton(product: productIndex!,),
              ],
            )
          ],
        ),
      ),
    );
  }
}


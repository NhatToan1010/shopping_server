import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/common/widgets/icons/circular_icon.dart';
import 'package:shopping_server/common/widgets/images/rounded_rect_image.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_card_add_to_cart_button.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_brand_text.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_price_text.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_title_text.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/features/shop/views/product_details/product_details_screen.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercent = controller.getSaleDiscount(product.salePrice, product.price);
    
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.productImageRadius),
            color: isDark ? AppPallete.backgroundDark : AppPallete.backgroundLight,
            border: Border.all(color: isDark ? AppPallete.softGrey : AppPallete.darkGrey, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Image Thumbnail
            RoundedContainer(
              height: double.infinity,
              width: 120,
              defaultBackgroundColor: false,
              backgroundColor: isDark ? AppPallete.backgroundDark : AppPallete.backgroundLight,
              child: Stack(
                children: [
                  // ----- Product Image
                  SizedBox(
                    height: double.infinity,
                    width: 120,
                    child: RoundedRectImage(
                      imageUrl: product.thumbnail,
                      backgroundColor: AppPallete.greyColor,
                      isNetworkImage: true,
                      fit: BoxFit.cover,
                    ),
                  ),
      
                  // ----- Sale Tag
                  if (product.salePrice > 0)
                    Positioned(
                      top: 14,
                      left: 8,
                      child: RoundedContainer(
                        width: 40,
                        radius: AppSize.small,

                        backgroundColor: Colors.amberAccent,
                        child: Center(
                          child: Text(
                            '$salePercent%', // Fetch Data
                            style: Theme.of(context).textTheme.labelLarge!.apply(color: AppPallete.blackColor),
                          ),
                        ),
                      ),
                    ),
      
                  // ----- Add Wishlist Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Iconsax.heart,
                      iconColor: Colors.red,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
      
            // ----- Product Main Content
            SizedBox(
              width: 175,
              child: Padding(
                padding: const EdgeInsets.only(left: AppSize.small, top: AppSize.small),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ----- Product Title
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ----- Product Name
                        ProductTitle(title: product.title ?? '', smallSize: false,),

                        // ----- Brand Name
                        ProductBrandText(brandName: product.brand!.brandName ?? '')
                      ],
                    ),

                    const Spacer(),

                    // ----- Product Price & Add to cart Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // --- Product Prices
                        Flexible(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                              ProductPriceText(
                                currencySign: '\$',
                                price: product.price.toString(),
                                isLarge: false,
                                lineThrough: true,
                              ),
                            ProductPriceText(
                              currencySign: '',
                              price: controller.getProductPrice(product),
                            ),
                          ],
                        ),),

                        const SizedBox(width: AppSize.medium),

                        // --- Add to cart button
                        ProductCardAddToCartButton(product: product),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

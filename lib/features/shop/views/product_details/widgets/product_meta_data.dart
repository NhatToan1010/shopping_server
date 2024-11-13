import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/images/rounded_rect_image.dart';
import 'package:shopping_server/common/widgets/texts/product_text/product_brand_text.dart';
import 'package:shopping_server/features/shop/controllers/products/product_controller.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_text/product_price_text.dart';
import '../../../../../common/widgets/texts/product_text/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/products/product_model.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----- Price & Sale Price
        Row(
          children: [
            // ===== Sale Tag
            if (product.salePrice > 0)
              Row(
                children: [
                  RoundedContainer(
                    width: 40,
                    radius: AppSize.small,
                    padding: const EdgeInsets.all(AppSize.extraSmall),
                    backgroundColor: Colors.amberAccent,
                    child: Center(
                      child: Text('${controller.getSaleDiscount(product.salePrice, product.price)}%',
                        // Fetch Data
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: AppPallete.blackColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.spaceBtwItems),
                ],
              ),

            // ===== Price
            ProductPriceText(
              currencySign: '\$',
              price: product.price.toString(),
              lineThrough: product.salePrice > 0 ? true : false,
              isLarge: product.salePrice > 0 ? false : true,
            ),
            const SizedBox(width: AppSize.spaceBtwItems),
            if (product.salePrice > 0)
              ProductPriceText(
                currencySign: '',
                price: controller.getProductPrice(product),
                isLarge: true,
              ),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        // *-----* Title
        ProductTitle(title: product.title, smallSize: false),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        // *-----* Stock Status
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProductTitle(title: 'Status:', smallSize: true),
            const SizedBox(width: AppSize.small),
            Text(
              product.stock > 0 ? 'In Stock' : 'Out of Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        // *-----* Brand
        Row(
          children: [
            FutureBuilder(
                future: controller.getBrandByProduct(product.brand!.id),
                builder: (_, snapshot) {
                  final brand = snapshot.data!;

                  return RoundedRectImage(
                    imageUrl: brand.image,
                    isNetworkImage: true,
                    width: 40,
                    height: 40,
                    imageColor: isDark
                        ? AppPallete.backgroundLight
                        : AppPallete.backgroundDark,
                    fit: BoxFit.cover,
                  );
                }),
            const SizedBox(width: AppSize.small),
            ProductBrandText(
                brandName: product.brand!.brandName, smallSize: false),
          ],
        ),
      ],
    );
  }
}

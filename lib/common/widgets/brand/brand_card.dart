import 'package:flutter/material.dart';
import 'package:shopping_server/features/shop/controllers/brand_controller.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/circle_image.dart';
import '../texts/product_text/product_brand_text.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brand,
  });

  final bool showBorder;
  final VoidCallback? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final isDark = HelperFunctions.isDarkMode(context);
    controller.getBrandProducts(brand.id).then((result) => brand.itemCount = result.length);

    return RoundedContainer(
      onTap: onTap,
      showBorder: showBorder,
      backgroundColor: AppPallete.transparentColor,
      padding: const EdgeInsets.all(AppSize.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ----- Icon -----
          Flexible(
            child: CircleImage(
              imageUrl: brand.image,
              isNetworkImage: true,
              imageColor: (isDark ? AppPallete.whiteColor : AppPallete.blackColor),
            ),
          ),
          const SizedBox(width: AppSize.small),

          // ----- Brand name & Product count
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductBrandText(
                  brandName: brand.brandName ?? '',
                  smallSize: true,
                ),
                Text(
                  '${brand.itemCount} products',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
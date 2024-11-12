import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/images/rounded_rect_image.dart';
import 'package:shopping_server/features/shop/models/brand_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;
  final BrandModel? brand;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: AppPallete.darkGrey,
      backgroundColor: AppPallete.transparentColor,
      padding: const EdgeInsets.all(AppSize.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Brand with product count
          Text(
            'Top Products',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSize.spaceBtwItems),

          // ===== Brand top 3 product images
          Row(
              children: images
                  .map((image) => brandTopProductImage(image, context))
                  .toList()),
        ],
      ),
    );
  }

  Widget brandTopProductImage(String image, context) {
    return Expanded(
      child: RoundedContainer(
        height: 140,
        radius: 10,
        showBorder: true,
        backgroundColor: HelperFunctions.isDarkMode(context)
            ? AppPallete.darkerGrey
            : AppPallete.whiteColor,
        margin: const EdgeInsets.all(AppSize.extraSmall),
        padding: const EdgeInsets.all(AppSize.small),
        child: RoundedRectImage(
          imageUrl: image,
          width: double.infinity,
          isNetworkImage: true,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

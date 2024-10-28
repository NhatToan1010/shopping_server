import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';

class ProductQuantityWithAddRemoveButton extends StatelessWidget {
  const ProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        CircularIcon(
          width: 32,
          height: 32,
          size: AppSize.medium,
          icon: Iconsax.minus,
          onPressed: remove,
          backgroundColor: isDark ? AppPallete.darkGrey : AppPallete.greyColor,
          iconColor: isDark ? AppPallete.whiteColor : AppPallete.blackColor,
        ),
        const SizedBox(width: AppSize.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: AppSize.spaceBtwItems),
        CircularIcon(
          width: 32,
          height: 32,
          size: AppSize.medium,
          icon: Iconsax.add,
          onPressed: add,
          backgroundColor: AppPallete.primary,
          iconColor: AppPallete.whiteColor,
        ),
      ],
    );
  }
}

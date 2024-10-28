import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SearchbarContainer extends StatelessWidget {
  const SearchbarContainer({
    super.key,
    this.showBackground = true,
    this.showBorder = true,
    this.onPressed, this.padding = const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
  });

  final bool showBackground, showBorder;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtils.getScreenWidth(),
          padding: const EdgeInsets.all(AppSize.medium),
          decoration: BoxDecoration(
            color: showBackground
                ? isDark
                    ? AppPallete.blackColor
                    : AppPallete.whiteColor
                : AppPallete.transparentColor,
            borderRadius: BorderRadius.circular(AppSize.borderRadiusLarge),
            border: showBorder
                ? Border.all(color: isDark ? AppPallete.lightGrey : AppPallete.darkGrey)
                : null,
          ),

          child: Row(
            children: [
              // ----- Icon Search
              Icon(
                Iconsax.search_normal,
                color: isDark ? AppPallete.greyColor : AppPallete.darkGrey,
              ),

              // ----- Search Text
              const SizedBox(width: AppSize.spaceBtwItems),
              Text(LocalTexts.search, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}

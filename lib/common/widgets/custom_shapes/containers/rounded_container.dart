import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = AppSize.cardRadiusLarge,
      this.child,
      this.showBorder = false,
      this.backgroundColor = AppPallete.whiteColor,
      this.margin,
      this.padding,
      this.borderColor = AppPallete.borderPrimary,
      this.onTap,
      this.defaultBackgroundColor = false,
      this.customColorBorder = false});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder, defaultBackgroundColor, customColorBorder;
  final Color backgroundColor, borderColor;
  final EdgeInsetsGeometry? margin, padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: defaultBackgroundColor
              ? (HelperFunctions.isDarkMode(context)
                  ? AppPallete.backgroundDark
                  : AppPallete.backgroundLight)
              : backgroundColor,
          border: showBorder
              ? Border.all(
                  width: 2,
                  color: customColorBorder
                      ? borderColor
                      : HelperFunctions.isDarkMode(context)
                          ? AppPallete.borderSecondary
                          : AppPallete.borderPrimary,
                )
              : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}

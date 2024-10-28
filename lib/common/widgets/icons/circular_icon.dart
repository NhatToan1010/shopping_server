import 'package:flutter/material.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.onPressed,
    this.iconColor = AppPallete.blackColor,
    this.useCustomColor = false,
    this.backgroundColor = AppPallete.transparentColor, this.size,
  });

  final IconData icon;
  final double? width, height;
  final VoidCallback? onPressed;
  final Color? iconColor, backgroundColor;
  final bool useCustomColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          size: size,
          icon,
          color: useCustomColor
              ? (HelperFunctions.isDarkMode(context) ? AppPallete.whiteColor : AppPallete.blackColor)
              : iconColor,
        ),
      ),
    );
  }
}

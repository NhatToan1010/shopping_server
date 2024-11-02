import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.width = 48,
    this.height = 48,
    this.backgroundColor,
    this.imageColor,
    this.isNetworkImage = false,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.padding,
    this.margin,
    this.imgWidth,
    this.imgHeight,
    this.onTap,
  });

  final double? width, height, imgWidth, imgHeight;
  final Color? backgroundColor, imageColor;
  final bool isNetworkImage;
  final String imageUrl;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding, margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          color: backgroundColor ??
              (isDark ? AppPallete.blackColor : AppPallete.whiteColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: isNetworkImage
              ? CachedNetworkImage(
                  width: imgWidth,
                  height: imgHeight,
                  imageUrl: imageUrl,
                  fit: fit,
                  color: imageColor,
                  progressIndicatorBuilder: (context, url, downloadIndicator) =>
                      const CustomShimmerEffect(width: 55, height: 55),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  width: imgWidth,
                  height: imgHeight,
                  image: AssetImage(imageUrl),
                  color: imageColor,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}

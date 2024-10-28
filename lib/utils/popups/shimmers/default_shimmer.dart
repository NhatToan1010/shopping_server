import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class CustomShimmerEffect extends StatelessWidget {
  const CustomShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 5,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:
              color ?? (isDark ? AppPallete.darkerGrey : AppPallete.lightGrey),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

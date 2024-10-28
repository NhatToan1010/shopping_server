import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator({
    super.key, required this.rating, required this.itemSize,
  });

  final double rating;
  final double itemSize;


  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: itemSize,
      unratedColor: AppPallete.greyColor,
      itemBuilder: (_, __) => Icon(
        Iconsax.star1,
        color: HelperFunctions.isDarkMode(context)
            ? AppPallete.secondary
            : AppPallete.primary,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:shopping_server/common/widgets/icons/circular_icon.dart';
import 'package:shopping_server/common/widgets/images/circle_image.dart';
import 'package:shopping_server/common/widgets/product_cart/ratings/custom_rating_bar_indicator.dart';
import 'package:shopping_server/common/widgets/texts/custom_read_more_text.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ----- Avatar & Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ----- Avatar & Name
                const CircleImage(
                  width: 32,
                  height: 32,
                  imageUrl: LocalImages.avatarBoy,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: AppSize.spaceBtwItems / 2),
                Text('Johnathan JoeStar', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),

            // ----- Menu More Button
            CircularIcon(icon: Icons.more_vert, onPressed: () {}),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 4),

        // ----- User Rating Indicator & Rated Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomRatingBarIndicator(rating: 4.0, itemSize: 10),
            Text('11-Jul-2024', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ----- User Comment
        const CustomReadMoreText(content: LocalTexts.userReview, trimLines: 2),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ----- Feedback User Review
        RoundedContainer(
          padding: const EdgeInsets.all(AppSize.medium),
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppPallete.darkGrey
              : AppPallete.greyColor,
          child: Column(
            children: [
              // ----- Company Name & Feedback Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shopping Server', style: Theme.of(context).textTheme.bodyLarge,),
                  Text('12-Jul-2024', style: Theme.of(context).textTheme.labelLarge,)
                ],
              ),
              const SizedBox(height: AppSize.spaceBtwItems),

              // ----- Feedback Content
              const CustomReadMoreText(content: LocalTexts.feedBack, trimLines: 2),
            ],
          ),
        ),
        const SizedBox(height: AppSize.spaceBtwSections,)
      ],
    );
  }
}

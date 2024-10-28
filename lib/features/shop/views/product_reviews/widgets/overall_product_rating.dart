import 'package:flutter/material.dart';
import 'package:shopping_server/features/shop/views/product_reviews/widgets/product_rating_indicator.dart';

import '../../../../../common/widgets/product_cart/ratings/custom_rating_bar_indicator.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ----- Rating Total Score
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('4.7', style: Theme.of(context).textTheme.displayLarge,),
              const CustomRatingBarIndicator(rating: 4.5, itemSize: 20),
            ],
          ),
        ),

        // ----- Product Rating Indicator
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              ProductRatingIndicator(label: '5', percentValue: 1.0,),
              ProductRatingIndicator(label: '4', percentValue: 0.8,),
              ProductRatingIndicator(label: '3', percentValue: 0.6,),
              ProductRatingIndicator(label: '2', percentValue: 0.4,),
              ProductRatingIndicator(label: '1', percentValue: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}

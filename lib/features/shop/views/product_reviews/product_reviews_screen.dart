import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/shop/views/product_reviews/widgets/overall_product_rating.dart';
import 'package:shopping_server/features/shop/views/product_reviews/widgets/user_review_card.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----- AppBar
      appBar: const CustomAppbar(title: Text('Reviews & Ratings'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- Description
              Text(
                'Rating and review have been verified and given by people used this product.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: AppSize.spaceBtwItems),

              // ----- Overall Product Rating
              const OverallProductRating(),
              const SizedBox(height: AppSize.spaceBtwSections),

              // ----- User Review List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

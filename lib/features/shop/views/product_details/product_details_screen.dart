import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/features/shop/views/checkout/checkout_screen.dart';
import 'package:shopping_server/features/shop/views/product_details/widgets/bottom_add_to_cart.dart';
import 'package:shopping_server/features/shop/views/product_details/widgets/product_attribute.dart';
import 'package:shopping_server/features/shop/views/product_details/widgets/product_image_slider.dart';
import 'package:shopping_server/features/shop/views/product_details/widgets/product_meta_data.dart';
import 'package:shopping_server/features/shop/views/product_details/widgets/rating_and_share.dart';
import 'package:shopping_server/features/shop/views/product_reviews/product_reviews_screen.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

import '../../../../common/widgets/texts/custom_read_more_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ----- Product Image Slider
              ProductImageSlider(product: product),
      
              // ----- Product Details
              Padding(
                padding: const EdgeInsets.all(AppSize.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Rating & Share Button
                    const RatingAndShare(),
      
                    // ===== Price, Title, Stock, & Brand
                    ProductMetaData(product: product),
                    const SizedBox(height: AppSize.spaceBtwItems),
      
                    // ===== Attributes, Colors, Sizes
                    if (product.productType == ProductType.variable.toString())
                      Column(
                        children: [
                          ProductAttribute(product: product),
                          const SizedBox(height: AppSize.spaceBtwSections),
                        ],
                      ),
      
                    // ===== Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const CheckoutScreen()),
                        child: const Text('Checkout'),
                      ),
                    ),
                    const SizedBox(height: AppSize.spaceBtwItems),
      
                    // ===== Description
                    const SectionHeading(title: 'Description', showActionButton: false),
                    const SizedBox(height: AppSize.spaceBtwItems),
      
                    CustomReadMoreText(content: product.description ?? '', trimLines: 2,),
      
                    const SizedBox(height: AppSize.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: AppSize.spaceBtwItems),
      
                    // ===== Reviews
                    SectionHeading(
                      title: 'Reviews',
                      onPressed: () => Get.to(() => const ProductReviewScreen()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      
        bottomNavigationBar: BottomAddToCart(product: product,),
      ),
    );
  }
}


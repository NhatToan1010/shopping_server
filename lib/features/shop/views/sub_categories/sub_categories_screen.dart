import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/images/rounded_rect_image.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_card_horizontal.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/shop/controllers/category_controller.dart';
import 'package:shopping_server/features/shop/views/all_product_view/all_product_view_screen.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';
import 'package:shopping_server/utils/popups/shimmers/horizontal_product_shimmer.dart';

import '../../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return SafeArea(
      child: Scaffold(
        // ----- AppBar
        appBar: CustomAppbar(title: Text(category.name), showBackArrow: true),
      
        // ----- Body
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              children: [
                // ----- Banner Image
                const RoundedRectImage(imageUrl: LocalImages.banner3, width: double.infinity),
                const SizedBox(height: AppSize.spaceBtwSections),
      
                // ----- Sub Categories
                FutureBuilder(
                  future: controller.getSubCategory(category.id),
                  builder: (context, snapshot) {
                    // --- Check snapshot state status
                    const loader = HorizontalProductShimmerEffect(itemCount: 2);
                    final widget = CloudHelperFunctions.checkMultipleStateRecord(
                        snapshot: snapshot, loader: loader);
      
                    if (widget != null) return widget;
      
                    // --- If snapshot has data
                    final subCategories = snapshot.data!;
      
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(width: AppSize.small),
                      itemCount: subCategories.length,
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];
      
                        return FutureBuilder(
                            future: controller.getCategoryProduct(categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              // --- Check snapshot state status
                              const loader = HorizontalProductShimmerEffect(itemCount: 2);
                              final widget = CloudHelperFunctions.checkMultipleStateRecord(snapshot: snapshot, loader: loader);
      
                              if (widget != null) return widget;
      
                              // --- If snapshot has data
                              final products = snapshot.data!;
      
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // ----- Heading
                                  SectionHeading(
                                    title: subCategory.name,
                                    showActionButton: true,
                                    onPressed: () => Get.to(
                                      () => AllProductViewScreen(
                                        title: subCategory.name,
                                        futureMethod:
                                            controller.getCategoryProduct(
                                                categoryId: subCategory.id,
                                                limit: -1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.spaceBtwItems),
      
                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: products.length,
                                      separatorBuilder: (context, __) =>
                                          const SizedBox(
                                        width: AppSize.spaceBtwItems,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ProductCardHorizontal(
                                          product: products[index],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.small),
                                  const Divider(),
                                  const SizedBox(height: AppSize.small),
                                ],
                              );
                            });
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

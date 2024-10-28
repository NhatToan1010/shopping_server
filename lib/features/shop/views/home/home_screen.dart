import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/product_cart/product_cards/product_card_vertical.dart';
import 'package:shopping_server/features/shop/controllers/products/product_controller.dart';
import 'package:shopping_server/features/shop/views/all_product_view/all_product_view_screen.dart';
import 'package:shopping_server/features/shop/views/home/widgets/header_container.dart';
import 'package:shopping_server/features/shop/views/home/widgets/home_appbar.dart';
import 'package:shopping_server/features/shop/views/home/widgets/home_banner_slider.dart';
import 'package:shopping_server/features/shop/views/home/widgets/home_categories.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/popups/shimmers/vertical_product_shimmer.dart';

import '../../../../common/widgets/custom_shapes/containers/searchbar_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              child: Column(
                children: [
                  // ===== Appbar
                  const HomeAppbar(),

                  // ===== Searchbar
                  SearchbarContainer(onPressed: () {}),
                  const SizedBox(height: AppSize.spaceBtwSections),

                  // ===== Categories
                  const Padding(
                    padding: EdgeInsets.only(left: AppSize.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(
                          title: LocalTexts.categories,
                          showActionButton: false,
                          textColor: AppPallete.whiteColor,
                        ),
                        SizedBox(height: AppSize.spaceBtwItems),

                        // ====== Category Items
                        HomeCategories()
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),
                  /*
                  - Last 'SizedBox' is for spacing between Header and Body section
                  */
                ],
              ),
            ),

            // -----Body-----

            // ===== Banner Carousel Slider
            const Padding(
                padding: EdgeInsets.all(AppSize.medium),
                child: HomeBannerSlider()),

            // ===== Product Section
            Padding(
              padding: const EdgeInsets.all(AppSize.defaultSpace),
              child: Column(
                children: [
                  // ===== Title
                  SectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => AllProductViewScreen(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeatureData(),
                      )),
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),

                  // ===== Product Gridview
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const VerticalProductShimmer();
                    }
                    if (controller.featureProducts.isEmpty) {
                      return const Center(child: Text('No Data Found!'));
                    }
                    else {
                      return GridLayout(
                        itemCount: controller.featureProducts.length,
                        mainAxisExtent: AppSize.productVerticalAxisExtent,
                        itemBuilder: (_, index) => ProductCardVertical(productIndex: controller.featureProducts[index],),
                      );
                    }
                  }),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

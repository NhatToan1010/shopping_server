import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/searchbar_container.dart';
import 'package:shopping_server/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_server/common/widgets/product_cart/carts/cart_icon.dart';
import 'package:shopping_server/features/shop/controllers/brand_controller.dart';
import 'package:shopping_server/features/shop/views/all_brand_view/all_brand_view_screen.dart';
import 'package:shopping_server/features/shop/views/cart/cart_screen.dart';
import 'package:shopping_server/features/shop/views/store/widgets/tab_categories.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/device/device_utility.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';
import 'package:shopping_server/utils/popups/shimmers/brand_shimmer.dart';

import '../../../../common/widgets/appbar/custom_tabbar.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/category_controller.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final categoryController = CategoryController.instance;
    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categoryController.featuredCategories.length,
      child: Scaffold(
        appBar: CustomAppbar(
          title: const Text('Store'),
          actions: [
            CartCounterIcon(
                onPressed: () => Get.to(() => const CartScreen()),
                applyDark: true,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrollAble) {
            return [
              // ----- Header Sections -----
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: isDark ? AppPallete.blackColor : AppPallete.whiteColor,
                expandedHeight: DeviceUtils.getScreenHeight() * 0.5,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSize.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: AppSize.spaceBtwItems),

                      // ----- Searchbar -----
                      const SearchbarContainer(padding: EdgeInsets.zero),
                      const SizedBox(height: AppSize.spaceBtwSections),

                      // ----- Featured Brands -----
                      SectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandViewScreen()),
                      ),
                      const SizedBox(height: AppSize.spaceBtwItems),

                      // ------ Brands GRID ------
                      Obx(
                        () {
                          if (brandController.isLoading.value) {
                            return const BrandShimmerEffect();
                          } else if (brandController.allBrands.isEmpty || brandController.featuredBrands.isEmpty) {
                            return const Center(child: Text('No Data Found!'));
                          }
                          return GridLayout(
                            mainAxisExtent: AppSize.productHorizontalAxisExtent,
                            itemCount: brandController.featuredBrands.length,
                            itemBuilder: (_, index) => BrandCard(
                                brand: brandController.featuredBrands[index],
                                onTap: () {},
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // ------ TabBar ------
                bottom: CustomTabBar(
                  tabs: categoryController.featuredCategories
                      .map((item) => Tab(child: Text(item.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categoryController.featuredCategories
                .map((item) => SingleChildScrollView(child: TabCategory(category: item)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

/*
  - Five Tab label: Sport - Electronic - Furniture - Clothes - Perfume
  - If you want to show Tab, you must have 'DefaultTabController' Above 'Scaffold'
  - Use TabBarView to navigate our tab label
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/brand/brand_card.dart';
import 'package:shopping_server/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_server/features/shop/controllers/brand_controller.dart';
import 'package:shopping_server/features/shop/views/all_product_view/widgets/brand_products.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/popups/shimmers/brand_shimmer.dart';

class AllBrandViewScreen extends StatelessWidget {
  const AllBrandViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return SafeArea(
      child: Scaffold(
        // ----- AppBar
        appBar: const CustomAppbar(title: Text('All Brand'), showBackArrow: true),
      
        // ----- Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              children: [
                Obx(
                () {
                  if (controller.isLoading.value) {
                    return const BrandShimmerEffect();
                  } else if (controller.allBrands.isEmpty) {
                    return const Center(child: Text('No Data Found!'));
                  }
                  return GridLayout(
                    itemCount: controller.allBrands.length,
                    itemBuilder: (context, index) =>
                        BrandCard(
                          showBorder: true,
                          onTap: () => Get.to(() => BrandProducts(brand: controller.allBrands[index],)),
                          brand: controller.allBrands[index],
                        ),
                    mainAxisExtent: 80,
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

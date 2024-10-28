import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/brand/brand_card.dart';
import 'package:shopping_server/common/widgets/product_cart/sortable/sortable_product.dart';
import 'package:shopping_server/features/shop/controllers/brand_controller.dart';
import 'package:shopping_server/features/shop/models/brand_model.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';
import 'package:shopping_server/utils/popups/shimmers/vertical_product_shimmer.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      // ----- AppBar
      appBar: CustomAppbar(title: Text(brand.brandName ?? ''), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            children: [
              BrandCard(brand: brand, showBorder: true),
              const SizedBox(height: AppSize.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer();
                  // --- Check snapshot state
                  final widget = CloudHelperFunctions.checkMultipleStateRecord(
                      snapshot: snapshot,
                      loader: loader,
                  );
                  if (widget != null) return widget;
                  
                  final products = snapshot.data!;
                  return SortableProduct(products: products,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

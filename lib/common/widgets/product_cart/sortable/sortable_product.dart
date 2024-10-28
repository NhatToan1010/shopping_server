import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/shop/controllers/products/all_product_controller.dart';

import '../../../../features/shop/models/products/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);

    return Column(
      children: [
        // ----- Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.sort),
            label: Text('Filter'),
            fillColor: Colors.transparent,
          ),
          focusColor: Colors.transparent,
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // --- Sort products by selected options below
            controller.sortProduct(value!);
            },
          items: ['Name', 'Highest Price', 'Lowest Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: AppSize.spaceBtwSections),

        // ----- Grid Products
        Obx(
        () => GridLayout(
            mainAxisExtent: AppSize.productVerticalAxisExtent,
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                ProductCardVertical(productIndex: controller.products[index]),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_server/features/shop/controllers/category_controller.dart';
import 'package:shopping_server/features/shop/models/category_model.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';
import 'brand_and_product_display.dart';

class TabCategory extends StatelessWidget {
  const TabCategory({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: FutureBuilder(
              // --- Get Sub Category from Main Category ex: Sport => Shoes, Tools
              future: controller.getSubCategory(category.id),
              builder: (context, subCategorySnapshot) {
                final subCategoryResponse = CloudHelperFunctions.checkMultipleStateRecord(snapshot: subCategorySnapshot);
                if (subCategoryResponse != null) return subCategoryResponse;

                // --- Get a list of sub category
                final subCategories = subCategorySnapshot.data!;

                // --- Return UI for each sub category items
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        // --- Get all product from each sub category
                        future: controller.getCategoryProduct(categoryId: subCategories[index].id),
                        builder: (context, productSnapshot) {
                          final productResponse = CloudHelperFunctions.checkMultipleStateRecord(snapshot: productSnapshot);
                          if (productResponse != null) return productResponse;

                          // --- Get a list of product for each sub category
                          final products = productSnapshot.data!;

                          // --- Return UI of each products for every sub category items
                          return BrandAndProductDisplay(products: products, index: index);
                        });
                  },
                  separatorBuilder: (context, _) => const SizedBox(height: AppSize.small),
                  itemCount: subCategories.length,
                );
              }),
        )
      ],
    );
  }
}

/*
 If you don't use 'ListView' to wrap all the block, contents inside will
 not be able to scroll
 */

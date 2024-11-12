import 'package:flutter/material.dart';
import 'package:shopping_server/features/shop/controllers/category_controller.dart';
import 'package:shopping_server/features/shop/models/category_model.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
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
          child: Column(
            children: [
              const SectionHeading(
                title: 'Products you might like',
                showActionButton: false,
              ),
              FutureBuilder(
                  // --- Get Sub Category from Main Category ex: Sport => Shoes, Tools
                  future: controller.getSubCategory(category.id),
                  builder: (context, subCategorySnapshot) {
                    final subCategoryResponse =
                        CloudHelperFunctions.checkMultipleStateRecord(
                            snapshot: subCategorySnapshot);
                    if (subCategoryResponse != null) return subCategoryResponse;

                    // --- Get a list of sub category
                    final subCategories = subCategorySnapshot.data!;

                    // --- Return UI for each sub category items
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: AppSize.small),
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
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: products.length > 3 ? products.length - 3 : products.length - 1,
                                  itemBuilder: (context, index) {
                                    return BrandAndProductDisplay(products: products, index: index);
                                  });
                            });
                      },
                    );
                  }),
            ],
          ),
        )
      ],
    );
  }
}

/*
 If you don't use 'ListView' to wrap all the block, contents inside will
 not be able to scroll
 */

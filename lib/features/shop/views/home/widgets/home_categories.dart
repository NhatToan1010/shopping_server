import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/shop/controllers/category_controller.dart';
import 'package:shopping_server/features/shop/views/sub_categories/sub_categories_screen.dart';
import 'package:shopping_server/utils/popups/shimmers/category_shimmer.dart';

import '../../../../../common/widgets/texts/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(
      () {
        if (controller.isLoading.value) {return const CategoryShimmerEffect();}

        if (controller.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No Data Found',
              style: Theme.of(context).textTheme.titleMedium!
                  .apply(color: AppPallete.lightGrey),
            ),
          );
        }
        return SizedBox(
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) {
              final item = controller.featuredCategories[index];

              return VerticalImageText(
                image: item.image,
                title: item.name,
                textColor: AppPallete.whiteColor,
                onPressed: () => Get.to(() => SubCategoriesScreen(category: item)),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banner_controller.dart';

class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const CustomShimmerEffect(width: double.infinity, height: 200);
      }
      if (controller.allBanner.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: controller.allBanner
                  .map(
                    (item) => RoundedRectImage(
                      imageUrl: item.image,
                      isNetworkImage: true,
                      onTap: () => Get.toNamed(item.targetScreen),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwItems),

            // ===== Banner Indicator
            Obx(
              // Refresh every time a banner is scrolled
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var bannerIndex = 0;
                      bannerIndex < controller.allBanner.length;
                      bannerIndex++)
                    CircularContainer(
                      width: 16,
                      height: 4,
                      margin: const EdgeInsets.only(
                          right: AppSize.spaceBtwItems / 2),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == bannerIndex
                              ? AppPallete.darkerGrey
                              : AppPallete.darkGrey,
                    ),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}

/*
  - This is Banner Slider where Sale discount or advertise set.
  - We use 'HomeController' to manage state of indicators
  - By handling 'onPageChanged' event, we navigate index of banner image and pass
  it to controller's value.
  - If controller's value is equal to index of banner then the indicator will
   have darker color than the others.
 */

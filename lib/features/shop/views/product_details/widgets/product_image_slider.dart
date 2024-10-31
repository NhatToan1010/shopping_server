import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/styles/shadows.dart';

import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/image_slider_controller.dart';
import '../../../models/products/product_model.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageSliderController());
    final images = controller.getFirstImage(product);

    return CurvedEdgesWidget(
      child: Container(
        color: AppPallete.backgroundLight,
        child: Stack(
          children: [
            // ===== Main Product Image
            SizedBox(
              height: 500,
              child: Obx(
                () {
                  final image = controller.currentImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.contain,
                      imageUrl: image,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AppPallete.primary,),
                    ),
                  );
                }
              ),
            ),

            // ===== AppBar
            CustomAppbar(
              showBackArrow: true,
              leadingColor: AppPallete.blackColor,
              actions: [
                CircularIcon(
                    iconColor: Colors.red,
                    icon: Iconsax.heart,
                    onPressed: () {},
                )
              ],
            ),

            // ===== Product Image Slider
            Positioned(
              right: 0,
              bottom: 32,
              left: AppSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSize.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(
                    () {
                      final selectedImage = controller.currentImage.value == images[index];
                      return RoundedRectImage(
                        boxShadow: [ShadowStyle.lightProductShadow],
                        border: Border.all(color: selectedImage ? AppPallete.darkGrey : AppPallete.transparentColor,),
                        width: 80,
                        fit: BoxFit.contain,
                        backgroundColor: isDark ? AppPallete.darkerGrey : AppPallete.lightGrey,
                        imageUrl: images[index],
                        isNetworkImage: true,
                        onTap: () => controller.currentImage.value = images[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


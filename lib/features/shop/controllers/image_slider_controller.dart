import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../models/products/product_model.dart';

class ImageSliderController extends GetxController {
  static ImageSliderController get instance => Get.find();

  final RxString currentImage = ''.obs;

  List<String> getFirstImage(ProductModel product) {
    List<String> images = [];

    currentImage.value = product.thumbnail;

    // Get all image from Product Model
    if (product.productType == ProductType.single.toString() && product.images != null) {
      images.addAll(product.images!);
    }

    // Get all image from product variation
    if (product.productType == ProductType.variable.toString()
        &&
       (product.productVariation != null || product.productVariation!.isNotEmpty)
    ) {
      images.addAll(product.productVariation!.map((variation) => variation.image));
    }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                height: 450,
                child: CachedNetworkImage(imageUrl: image),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 100,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/features/shop/controllers/image_slider_controller.dart';
import 'package:shopping_server/utils/popups/shimmers/default_shimmer.dart';

import '../../../../../common/widgets/images/circle_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final imageController = Get.put(ImageSliderController());

    return Column(
      children: [
        Obx(() {
          final networkImage = controller.user.value.profilePicture;
          final image = networkImage.isEmpty ? LocalImages.avatar2 : networkImage;
          return controller.isImageLoading.value
              ? const CustomShimmerEffect(width: 55, height: 55, radius: 80,)
              : CircleImage(
                  imageUrl: image,
                  width: 55,
                  height: 55,
                  isNetworkImage: networkImage.isNotEmpty,
                  fit: BoxFit.cover,
                  onTap: () => imageController.showEnlargedImage(image),
                );
        }),
        const SizedBox(height: AppSize.spaceBtwItems / 2),
        TextButton(
          onPressed: () => controller.uploadUserImage(),
          child: Text('Change Profile Image', style: Theme.of(context).textTheme.labelLarge),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/features/personalization/views/profile/profile_screen.dart';

import '../../../../../common/widgets/images/circle_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      // ----- Avatar
      leading: CircleImage(
        imageUrl: controller.user.value.profilePicture.isEmpty
            ? LocalImages.avatar2
            : controller.user.value.profilePicture,
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(0),
        isNetworkImage: controller.user.value.profilePicture.isNotEmpty,
        fit: BoxFit.cover,
      ),

      // ----- User Firstname
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: AppPallete.whiteColor),
      ),
      // ----- Email
      subtitle: Text(
        AuthenticationRepository.instance.authUser!.email ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: AppPallete.whiteColor.withOpacity(0.8)),
      ),
      // ----- Edit Profile Button
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Iconsax.edit),
        color: AppPallete.whiteColor,
      ),
    );
  }
}

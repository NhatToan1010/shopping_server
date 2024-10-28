import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/features/personalization/views/profile/widgets/change_name_screen.dart';
import 'package:shopping_server/features/personalization/views/profile/widgets/profile_menu.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/popups/dialog.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Column(
      children: [
        const SizedBox(height: AppSize.spaceBtwItems),
        const Divider(),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ----- Profile Information
        // ===== Title
        const SectionHeading(
          title: 'Profile Information',
          showActionButton: false,
        ),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ===== List Menus
        ProfileMenu(
          title: 'Name',
          value: controller.user.value.fullName,
          onTap: () => Get.off(() => const ChangeNameScreen()),
          leadingIcon: Iconsax.user,
        ),
        ProfileMenu(
          title: 'Username',
          value: controller.user.value.userName,
          onTap: () {},
          leadingIcon: Iconsax.text,
        ),

        const SizedBox(height: AppSize.spaceBtwItems),
        const Divider(),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ----- Personal Information
        // ===== Title
        const SectionHeading(title: 'Personal Information', showActionButton: false),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ===== List Menus
        ProfileMenu(
          title: 'User ID',
          value: controller.user.value.id,
          icon: Iconsax.copy,
          onTap: () {}, leadingIcon: Iconsax.personalcard,
        ),
        ProfileMenu(
          title: 'E-Mail',
          value: controller.user.value.email,
          leadingIcon: Iconsax.direct_down,
          onTap: () {},
        ),
        ProfileMenu(
          title: 'Phone Number',
          value: controller.user.value.phoneNumber,
          leadingIcon: Iconsax.mobile,
          onTap: () {},
        ),
        ProfileMenu(
          title: 'Date of Birth',
          value: '10 Oct 2002',
          leadingIcon: Iconsax.calendar,
          onTap: () {},
        ),

        const SizedBox(height: AppSize.spaceBtwItems),
        const Divider(),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ----- Delete Account Button
        TextButton(
          onPressed: () => CustomDialog.deleteAccountWarningDialog(
              onConfirmPressed: () => controller.deleteUserAccount()),
          child: Text(
            'Delete Account',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .apply(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

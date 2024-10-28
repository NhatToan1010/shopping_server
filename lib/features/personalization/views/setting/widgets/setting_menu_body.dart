import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/personalization/views/address/user_address_screen.dart';
import 'package:shopping_server/features/personalization/views/setting/widgets/setting_menu_title.dart';
import 'package:shopping_server/features/personalization/views/setting/widgets/upload_data_screen.dart';
import 'package:shopping_server/features/shop/views/cart/cart_screen.dart';
import 'package:shopping_server/features/shop/views/order/my_order_screen.dart';
import 'package:shopping_server/utils/popups/dialog.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../data/repositories/authentication_repository.dart';
import '../../../../../utils/constants/sizes.dart';

class SettingMenuBody extends StatelessWidget {
  const SettingMenuBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepository.instance;
    return Column(
      children: [
        // ----- Account Setting
        // ===== Title
        const SectionHeading(title: 'Account Setting', showActionButton: false),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ===== List Menus
        SettingMenuTitle(
          iconLeading: Iconsax.location,
          title: 'My Address',
          subtitle: 'Set your delivery address',
          onTap: () => Get.to(() => const UserAddressScreen()),
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.shopping_cart,
          title: 'My Cart',
          subtitle: 'Add, remove your products and checkout',
          onTap: () => Get.to(() => const CartScreen()),
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.bag_tick,
          title: 'My Orders',
          subtitle: 'Check your recent orders',
          onTap: () => Get.to(() => const MyOrderScreen()),
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.bank,
          title: 'Bank Account',
          subtitle: 'Withdraw balance to registered bank account',
          onTap: () {},
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.discount_circle,
          title: 'My Coupon',
          subtitle: 'List of all discount coupons',
          onTap: () {},
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.notification,
          title: 'Notification',
          subtitle: 'Set your kind of notification messages',
          onTap: () {},
        ),
        SettingMenuTitle(
          iconLeading: Iconsax.security_user,
          title: 'Account Privacy',
          subtitle: 'Manage data usage and connected accounts',
          onTap: () {},
        ),
        const SizedBox(height: AppSize.spaceBtwSections),

        // ----- App Setting
        // ===== Title
        const SectionHeading(title: 'App Setting', showActionButton: false),
        const SizedBox(height: AppSize.spaceBtwItems),

        // ===== List Menus
        SettingMenuTitle(
          iconLeading: Iconsax.document_upload,
          title: 'Load Data',
          subtitle: 'Upload your data to our server',
          onTap: () => Get.to(() => const UploadDataScreen()),
        ),
        SettingMenuTitle(
            iconLeading: Iconsax.direct_down,
            title: 'Geolocation',
            subtitle: 'Set recommendation based on location',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            )),
        SettingMenuTitle(
            iconLeading: Iconsax.security_safe,
            title: 'Safe Mode',
            subtitle: 'Search result is safe for all ages',
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            )),
        SettingMenuTitle(
            iconLeading: Iconsax.image,
            title: 'HD Image Quality',
            subtitle: 'Set your image quality',
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            )),
        const SizedBox(height: AppSize.spaceBtwSections),

        // ----- Log Out Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
              onPressed: () => CustomDialog.alertDialog(
                  title: 'Logout',
                  message: 'Are you sure you want logout?',
                  onPressed: () => auth.logout()),
              child: const Text('Log Out')),
        )
      ],
    );
  }
}

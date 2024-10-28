import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/views/setting/widgets/setting_menu_body.dart';
import 'package:shopping_server/features/personalization/views/setting/widgets/user_profile_title.dart';
import 'package:shopping_server/features/shop/views/home/widgets/header_container.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ----- Header
            HeaderContainer(
              child: Column(
                children: [
                  CustomAppbar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppPallete.whiteColor),
                    ),
                  ),
                  const UserProfileTitle(),
                  const SizedBox(height: AppSize.spaceBtwSections),
                  /*
                  - Last 'SizedBox' is used for spacing between Header and Body section
                 */
                ],
              ),
            ),

            // ----- Body
            const Padding(
              padding: EdgeInsets.all(AppSize.defaultSpace),
              child: SettingMenuBody(),
            )
          ],
        ),
      ),
    );
  }
}

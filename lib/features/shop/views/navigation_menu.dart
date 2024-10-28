import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/personalization/views/setting/setting_screen.dart';
import 'package:shopping_server/features/shop/views/home/home_screen.dart';
import 'package:shopping_server/features/shop/views/store/store_screen.dart';
import 'package:shopping_server/features/shop/views/wishlist/wishlist_screen.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: isDark ? AppPallete.blackColor : AppPallete.whiteColor,
          indicatorColor: isDark ? AppPallete.blackColor : AppPallete.whiteColor,
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            // ----- Home
            NavigationDestination(icon: Icon(Iconsax.home), label: LocalTexts.home),

            // ----- Store
            NavigationDestination(icon: Icon(Iconsax.shop), label: LocalTexts.store),

            // ----- Wishlist
            NavigationDestination(icon: Icon(Iconsax.heart), label: LocalTexts.wishlist),

            // ----- Profile
            NavigationDestination(icon: Icon(Iconsax.user), label: LocalTexts.profile),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const SettingScreen(),
  ];
}

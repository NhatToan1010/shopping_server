import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return TabBar(
      isScrollable: true,
      indicatorColor: AppPallete.primary,
      labelColor: isDark ? AppPallete.whiteColor : AppPallete.blackColor,
      unselectedLabelColor: AppPallete.darkGrey,
      tabs: tabs,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppbarHeight());
}

import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class SpacingStyles {
  static const EdgeInsetsGeometry paddingWithAppbarHeight = EdgeInsets.only(
    top: AppSize.appbarHeight,
    left: AppSize.defaultSpace,
    bottom: AppSize.defaultSpace,
    right: AppSize.defaultSpace,
  );
}

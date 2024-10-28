import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

class ShadowStyle {

  static final lightProductShadow = BoxShadow(
    color: AppPallete.darkGrey.withOpacity(0.2),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final darkProductShadow = BoxShadow(
      color: AppPallete.lightGrey.withOpacity(0.2),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}
import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/images/circle_image.dart';

import '../../../utils/constants/sizes.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleImage(
          width: AppSize.iconLarge,
          height: AppSize.iconLarge,
          imageUrl: icon),
    );
  }
}

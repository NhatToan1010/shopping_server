import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';

class SaleTagWidget extends StatelessWidget {
  const SaleTagWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: width,
      height: height,
      radius: AppSize.small,
      padding: const EdgeInsets.all(AppSize.extraSmall),
      backgroundColor: Colors.amberAccent,
      child: Text(
        '25%', // Fetch Data
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .apply(color: AppPallete.blackColor),
      ),
    );
  }
}


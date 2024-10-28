import 'package:flutter/material.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

class ProductRatingIndicator extends StatelessWidget {
  const ProductRatingIndicator({
    super.key,
    required this.label,
    required this.percentValue,
  });

  final String label;
  final double percentValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 9,
          child: SizedBox(
            width: DeviceUtils.getScreenWidth() * 0.8,
            child: LinearProgressIndicator(
              backgroundColor: AppPallete.greyColor,
              borderRadius: BorderRadius.circular(7),
              minHeight: 10,
              value: percentValue,
              valueColor: AlwaysStoppedAnimation(
                HelperFunctions.isDarkMode(context)
                    ? AppPallete.secondary
                    : AppPallete.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

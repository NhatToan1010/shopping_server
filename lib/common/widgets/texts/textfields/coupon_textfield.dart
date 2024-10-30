import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class CouponTextField extends StatelessWidget {
  const CouponTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      showBorder: true,
      defaultBackgroundColor: true,
      padding: const EdgeInsets.symmetric(
          vertical: AppSize.small, horizontal: AppSize.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ----- TextField
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter coupon code here',
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),

          // ----- Apply Button
          SizedBox(
            width: 80,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: isDark
                      ? AppPallete.whiteColor.withOpacity(0.7)
                      : AppPallete.blackColor.withOpacity(0.7),
                  backgroundColor:
                      isDark ? AppPallete.darkGrey : AppPallete.greyColor,
                  side:
                      BorderSide(color: AppPallete.greyColor.withOpacity(0.2))),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}

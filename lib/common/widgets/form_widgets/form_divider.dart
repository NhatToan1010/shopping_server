import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_functions.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key, this.method,
  });

  final String? method;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDark ? AppPallete.greyColor : AppPallete.darkGrey,
            thickness: 0.5,
            indent: 60,
            endIndent: 10,
          ),
        ),
        Text(
          '${LocalTexts.or}$method',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: isDark ? AppPallete.greyColor : AppPallete.darkGrey,
            thickness: 0.5,
            indent: 10,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}

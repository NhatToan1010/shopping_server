import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/images/circle_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    required this.textColor,
    this.onPressed,
  });

  final String image, title;
  final Color textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSize.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Icon
            CircleImage(
              width: 56,
              height: 56,
              imgWidth: 40,
              imgHeight: 40,
              padding: const EdgeInsets.all(AppSize.small),
              imageUrl: image,
              isNetworkImage: true,
              backgroundColor: AppPallete.lightGrey,
            ),
            const SizedBox(height: AppSize.spaceBtwItems / 2),
            // Category Title
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
